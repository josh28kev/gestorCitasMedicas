var TablaP = Table || {};

TablaP.refresh= function(table){
    body = table.tBodies[0];
    while (body.firstChild) body.removeChild(body.firstChild);
    model = retrieve(table.modelId);
    rows= TablaP.toRows(model,table.toCell);
    for (i=0;i<rows.length;i++) body.appendChild(rows[i]);    
};

TablaP.toRows= function(objs, toCell){
    rows =  new Array();
    for (i=0;i<objs.size();i++){
      obj = objs.get(i);
      row=TablaP.toRow(obj,toCell,i);
      rows.push(row);
    }
    return rows;
};

TablaP.toRow= function(obj,toCell,rowIdx){	
    var row=document.createElement("tr");
    for(var colIdx=0;;colIdx++){
        var cellContent=toCell(obj,colIdx);
        if (cellContent===null) break;
        var cell=document.createElement("td");
        cellContent.rowIdx=rowIdx;
        cell.appendChild(cellContent);
        row.appendChild(cell);
    }
    return row;
};