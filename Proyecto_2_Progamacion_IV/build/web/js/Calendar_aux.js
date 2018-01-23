
				function CalendarClass() {
  // CalendarClass
	// Copyright © 2008 Sebastián Serrani
	//
  // Este programa es software libre: usted puede redistribuirlo y/o modificarlo
  // conforme a los términos de la Licencia Pública General de GNU publicada por
  // la Fundación para el Software Libre, ya sea la versión 3 de esta Licencia o
  // (a su elección) cualquier versión posterior.
  // Este programa se distribuye con el deseo de que le resulte útil, pero SIN
  // GARANTÍAS DE NINGÚN TIPO; ni siquiera con las garantías implícitas de
  // COMERCIABILIDAD o APTITUD PARA UN PROPÓSITO DETERMINADO. Para más información,
  // consulte la Licencia Pública General de GNU.
  // Junto con este programa, se debería incluir una copia de la Licencia Pública
  // Pública General de GNU. De no ser así, ingrese a <http://www.gnu.org/licenses/>.
  //
  // This program is free software: you can redistribute it and/or modify
  // it under the terms of the GNU General Public License as published by
  // the Free Software Foundation, either version 3 of the License, or
  // (at your option) any later version.
  // This program is distributed in the hope that it will be useful,
  // but WITHOUT ANY WARRANTY; without even the implied warranty of
  // MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  // GNU General Public License for more details.
  // You should have received a copy of the GNU General Public License
  // along with this program.  If not, see <http://www.gnu.org/licenses/>.

  var now = new Date();
  var nowYear = now.getFullYear();
  var nowMonth = now.getMonth();
  var nowDay = now.getDate();
  var set = new Date();
  var monthDaysY = new Array('31','28','31','30','31','30','31','31','30','31','30','31');
  var monthDaysL = new Array('31','29','31','30','31','30','31','31','30','31','30','31');
  //var weekDays = new Array('D','L','M','M','J','V','S');
  var dataFormat = new Array('d', 'm', 'y');
  var dataSeparator = '/';
  this.calendarId = 'calendar'+new Date().getTime();
  this.calendarDays = new Array();
  this.monthNames = new Array('ENE','FEB','MAR','ABR','MAY','JUN','JUL','AGO','SEP','OCT','NOV','DIC');
  this.inputField = null;

  //
  // OBJECT FUNCTIONS
  //

  function $(id) {
  // Gets an element object by Id
  // Params:
  //   id: the element Id
  // Usage:
  //   JS: var elementObject = $('elementId');
  //   JS: elementObject.style.display = 'none';
  //   HTML: <input type="text" id="elementId">
    if (typeof id == 'string'){
      var elementObj = (document.getElementById(id))? document.getElementById(id) : null;
      if (elementObj != null){
        return ((typeof(elementObj.type) != 'undefined') || (elementObj.id != null))? elementObj : false;
      } else {
        return false;
      }
    } else {
      return id;
    }
  }
  this.objLeft = function (elementObj) {
  // Gets the distance from the left of an element
  // Params:
  //   elementObj: the element object
  // Usage:
  //   JS: var cal = new CalendarClass;
  //   HTML: <input id="myInput" type="text" onclick="alert(cal.objLeft(this));">
    var leftDistance = 0;
    if (elementObj.offsetParent) {
      while (elementObj.offsetParent) {
        leftDistance += elementObj.offsetLeft
        elementObj = elementObj.offsetParent;
      }
    } else if (elementObj.x) {
      leftDistance += elementObj.x;
    }
    return leftDistance;
  }
  this.objTop = function (elementObj) {
  // Gets the distance from the top of an element
  // Params:
  //   elementObj: the element object
  // Usage:
  //   JS: var cal = new CalendarClass;
  //   HTML: <input id="myInput" type="text" onclick="alert(cal.objTop(this));">
    var topDistance = 0;
    if (elementObj.offsetParent) {
      while (elementObj.offsetParent) {
        topDistance += elementObj.offsetTop
        elementObj = elementObj.offsetParent;
      }
    } else if (elementObj.y) {
      topDistance += elementObj.y;
    }
    return topDistance;
  }

  //
  // CALENDAR FUNCTIONS
  //

  this.makeCalendar = function(){
  // Fills a months array, considering the leap and normal years.
  // Usage:
  //   this.makeCalendar();

  // try to get de date ser on the input!!
	  var selectedYear = set.getFullYear();
    var selectedMonth = set.getMonth();
    var selectedDay = set.getDate();
    var monthsArray = ((selectedYear % 4) == 0) ? monthDaysL : monthDaysY;
    var dayOfWeek = set.getDay();
    for (var validDay = j = 1; j <= 42; j++) {
      var validPart1 = (j >= (dayOfWeek -(-1)));
      var validPart2 = (j <= dayOfWeek - (-monthsArray[selectedMonth]));
      if (validPart1 && validPart2) {
        this.calendarDays[j] = validDay;
        validDay++;
      } else {
        this.calendarDays[j] = '0';
      }
    }
  }
  this.makeDateString = function(trigger){
  // Generates the final string to be put in a input field.
  // This is call from the event control function
  // Params:
  //   trigger: usualy the TD object from the calendar from wich take de day
  // Usage:
  //   cal.makeDateString(response);
    var stringFormat = new Array();
    stringFormat['y'] = set.getFullYear();
    stringFormat['m'] = (set.getMonth()+1);
    stringFormat['d'] = (trigger)? trigger.firstChild.nodeValue : set.getDate();
    this.setCalendarDate(stringFormat['y'], (stringFormat['m']-1), stringFormat['d']);
    $(this.inputField).value = stringFormat[dataFormat[0]]+dataSeparator+stringFormat[dataFormat[1]]+dataSeparator+stringFormat[dataFormat[2]];
  }
  this.setCalendarDate = function(selectedYear, selectedMonth, selectedDay){
  // Sets the choosen date
  // Params:
  //   selectedYear: the new year wich will be set
  //   selectedMonth: the new month wich will be set
  //   selectedDay: the new day wich will be set
  // Usage:
  //   this.setCalendarDate(2009,12,18);  // sets the date to 18/12/2009 in yyyy/mm/dd format
    set.setDate((selectedDay==null)? 1 : parseInt(selectedDay));
	  set.setMonth((selectedMonth==null)? nowMonth : selectedMonth);
    set.setFullYear((selectedYear==null)? nowYear : selectedYear);
  }
  this.getDataConfig = function(param){
  // Gets the date set by the user
  // Params:
  //   param: wich element return, year, month or day
  // Usage:
  //   this.getDataConfig('y');  // will return the set year
    switch(param){
      case 'y':
        return set.getFullYear();
        break;
      case 'm':
        return set.getMonth();
        break;
      case 'd':
        return set.getDate();
        break;
      default:
        return set.getFullYear();
    }
  }
  this.getPrevious = function(param){
  // Gets the previous year, month or day
  // Params:
  //   param: wich element should change: year, month or day
  // Usage:
  //  this.getPrevious('m');  // to get the previous month
	  var selectedYear = set.getFullYear();
    var selectedMonth = set.getMonth()-1;
    var selectedDay = set.getDate();
    switch(param){
      case 'y':
        selectedYear -= 1;
        break;
      case 'm':
        selectedMonth -= 1;
        if (selectedMonth < 0) { selectedMonth = 11; selectedYear -= 1; }
        break;
      case 'd':
        var monthsArray = ((selectedYear % 4) == 0) ? monthDaysL : monthDaysY;
        selectedDay -= 1;
        if (selectedDay < 0) { selectedMonth -= 1; selectedDay = monthsArray[selectedMonth]; }
        break;
    }
    this.setCalendarDate(selectedYear, selectedMonth, selectedDay);
    return true;
  }
  this.getNext = function(param){
  // Gets the next year, month or day
  // Params:
  //   param: wich element should change: year, month or day
  // Usage:
  //  this.getNext('d');  // to get the next day
	  var selectedYear = set.getFullYear();
    var selectedMonth = set.getMonth();
    var selectedDay = set.getDate();
    switch(param){
      case 'y':
        selectedYear += 1;
        break;
      case 'm':
        selectedMonth += 1;
        if (selectedMonth > 11) { selectedMonth = 0; selectedYear += 1; }
        break;
      case 'd':
        var monthsArray = ((selectedYear % 4) == 0) ? monthDaysL : monthDaysY;
        selectedDay += 1;
        if (selectedDay > monthsArray[selectedMonth]) { selectedMonth = 1; }
        break;
    }
    this.setCalendarDate(selectedYear, selectedMonth, selectedDay);
    return true;
  }

  //
  // HTML/DOM/JS OBJECTS
  //

  this.createDOMElement = function(elementType, elementText, elementAttributes){
  // Creates a DOM node, asigns text to it and attributes if any
  // Params:
  //   elementType: type of node to create
  //   elementText: the text of the node
  //   elementAttributes: array of attributes
  // Usage:
  //   this.createDOMElement('div', 'Text within Div!', new Array('class','divClass','style','border: 1px'));
    var newElement = document.createElement(elementType);
    if (elementText){
      newElement.appendChild(document.createTextNode(elementText));
    }
    if (elementAttributes && elementAttributes.length > 0){
      for (var j = 0; j < elementAttributes.length; j = j+2){
        newElement.setAttribute(elementAttributes[j],elementAttributes[j+1]);
        if (elementAttributes[j] == 'style'){ // For IE
          newElement.style.cssText = elementAttributes[j+1];
        }
      }
    }
    return newElement;
  }
  this.removeChildrenFromNode = function(domNode){
  // Removes children nodes from a given one
  // Params:
  //   domNode: the node from wich remove children
  // Usage:
  //   this.removeChildrenFromNode(tableNode);
    if(domNode == undefined && domNode == null) {
      return;
    }
    while (domNode.hasChildNodes()){
      domNode.removeChild(domNode.firstChild);
    }
  }
  this.showCalendar = function(inputField){
  // Shows the calendar
  // Params:
  //   inputField: the input field (ID) to wich attach the calendar
  // Usage:
  //   JS: var cal = new CalendarClass;
  //   HTML: <input id="myInput" type="text" onclick="this.select(); cal.showCalendar(this);">
    this.cancelBubbling(inputField);
    this.inputField = (!inputField.id)?inputField:inputField.id;
    $(this.inputField).value = '';
    if (!$(this.calendarId)){
      var htmlBody = document.getElementsByTagName('body')[0];
      var calendarDiv = this.createDOMElement('div', null, new Array('id', this.calendarId, 'class', 'calendar', 'style', 'display: none; position: absolute; left: '+this.objLeft(inputField)+'px; top: '+(this.objTop(inputField) + inputField.offsetHeight)+'px;'));
      calendarDiv.setAttribute('className', 'calendar'); // For IE
      htmlBody.appendChild(calendarDiv);
    } else {
      var calendarDiv = $(this.calendarId);
      this.removeChildrenFromNode(calendarDiv);
    }
    this.makeCalendar();
    // Table DOM construction
    var tableDOM = document.createElement("table");
    tableDOM.setAttribute('style','width: 100%');
    tableDOM.style.cssText = 'width: 100%'; // For IE
    // Creates de table Header
    var tableHeader = document.createElement("thead");
    var headerText = new Array();
    headerText[0] = this.createDOMElement('a', '<', new Array('href','javascript: cal2.getPrevious(\'m\'); cal2.showCalendar(\''+this.inputField+'\');'));
    headerText[1] = this.createDOMElement('strong', this.monthNames[cal2.getDataConfig('m')]+' '+cal2.getDataConfig('y'), null);
    headerText[2] = this.createDOMElement('a', '>', new Array('href','javascript: cal2.getNext(\'m\'); cal2.showCalendar(\''+this.inputField+'\');'));
    var headerRow = document.createElement("tr");
    for(var j = 0; j < 3; j++) {
        headerCell = document.createElement("th");
        headerCell.appendChild(headerText[j]);
        if (j==1){ headerCell.setAttribute('colSpan','5'); }
        headerRow.appendChild(headerCell);
    }
    tableHeader.appendChild(headerRow);
    tableDOM.appendChild(tableHeader);
    // Creates de table body
    var tableBody = document.createElement("tbody");
    // Week days
    var daysRow = document.createElement("tr");
    //for(var j = 0; j < 7; j++) {
    // daysRow.appendChild(this.createDOMElement('td', weekDays[j], new Array('class','weekdays')));
   // }
    tableBody.appendChild(daysRow);
    // Days
    var dayNumb = this.calendarDays;
    for(var j=1; j<=6; j++) {
    	var bodyRow = document.createElement("tr");
    	for(var k=1;k<=7;k++) {
    		var l = 7 * (j-1) - (-k);
    		if (dayNumb[l] != 0) {
          if (dayNumb[l] == nowDay && nowMonth == cal2.getDataConfig('m')) {
            var cellAttrib = new Array('style','font-weight: bold');
          } else {
            var cellAttrib = null;
          }
        } else {
          dayNumb[l] = '';
          var cellAttrib = null;
        }
        bodyRow.appendChild(this.createDOMElement('td', dayNumb[l], cellAttrib));
    	}
    	tableBody.appendChild(bodyRow);
    }
    tableDOM.appendChild(tableBody);
    tableDOM.setAttribute('class','calendar');
    calendarDiv.appendChild(tableDOM);
    calendarDiv.style.display = 'block';
    document.onclick = cal2.controlCalendar;
  }

  //
  // EVENTS FUNCTIONS
  //

  this.cancelBubbling = function(e){
  // Cancel events bubbling
  // Params:
  //   e: the event
  // Usage:
  //   this.cancelBubbling(inputFieldonClickEvent);
    if (!e) {
      var e = window.event;
    }
    if (!e.stopPropagation){
      e.cancelBubble = true;
    } else {
      e.stopPropagation();
    }
  }
  this.controlCalendar = function(e){
  // Control events over the calendar
  // Params:
  //   e: the event
  // Usage:
  //   var cal = new CalendarClass;
  //   document.onclick = cal.controlCalendar;
    if ($(cal2.calendarId)){
      response = cal2.clickedOutsideElement(cal2.calendarId, e);
      if(response == true){
        document.getElementById(cal2.calendarId).style.display='none';
      } else {
        responseVal = (response.hasChildNodes())? response.firstChild.nodeValue : null;
        if (!isNaN(responseVal) && responseVal != null && responseVal.length > 0){
          cal2.makeDateString(response);
          document.getElementById(cal2.calendarId).style.display='none';
          document.getElementById(cal2.inputField).focus();
        } else {
          return true;
        }

      }
    }
  }
  this.clickedOutsideElement = function(elemId, e) {
  // Checks if the user clicked outside the calendar
  // Params:
  //   elemId: If of the element
  //   e: the event
  // Usage:
  //   if (cal.clickedOutsideElement(cal.calendarId, e)) { ... }
    if (!e){
      var theElement = cal2.getEventTarget(window.event);
    } else {
      var theElement = cal2.getEventTarget(e);
    }
    var rElement = theElement;
    while(theElement != null) {
      if(theElement.id == elemId){
        return rElement;
      }
      theElement = theElement.offsetParent;
    }
    return theElement?theElement:true;
  }
  this.getEventTarget = function(evt) {
  // Gets the target of an event
  // Params:
  //   evt: the event
    var eTarget = (evt.target) ? evt.target : evt.srcElement;
    if(eTarget != null) {
      if(eTarget.nodeType == 3){
        eTarget = eTarget.parentNode;
      }
    }
    return eTarget;
  }
}
var cal2 = new CalendarClass;