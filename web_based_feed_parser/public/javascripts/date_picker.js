






// <!-- <![CDATA[

// Project: Dynamic Date Selector (DtTvB) - 2006-03-16
// Script featured on JavaScript Kit- http://www.javascriptkit.com
// Code begin...
// Set the initial date.
var select_date=100;
var textbox_id;
var clear_button;
var time_button;
var current_month=100;
var current_date=100;
var current_year=100;
var ds_i_date = new Date();
var minute_string=new String("<select name='hours' id='minutes'><option value='00'>mm</option>");
for(var min=0;min<60;min++)
{
 if (min<10)
 {minute_string+="<option value='"+"0"+min+"'>"+"0"+min+"</option>";}
 else
 {minute_string+="<option value='"+min+"'>"+min+"</option>";}

}
minute_string+="</select>";
var seconds_string=new String("<select name='seconds' id='seconds'><option value='00'>ss</option>");
for(var min=0;min<60;min++)
{ if (min<10)
 { seconds_string+="<option value='"+"0"+min+"'>"+"0"+min+"</option>";}
 else
 {seconds_string+="<option value='"+min+"'>"+min+"</option>"; }

}

seconds_string+="</select>";
ds_c_month = ds_i_date.getMonth() + 1;
ds_c_year = ds_i_date.getFullYear();

// Get Element By Id
function ds_getel(id) {
	return document.getElementById(id);
}

// Get the left and the top of the element.
function ds_getleft(el) {
	var tmp = el.offsetLeft;
	el = el.offsetParent
	while(el) {
		tmp += el.offsetLeft;
		el = el.offsetParent;
	}
	return tmp;
}
function ds_gettop(el) {
	var tmp = el.offsetTop;
	el = el.offsetParent
	while(el) {
		tmp += el.offsetTop;
		el = el.offsetParent;
	}
	return tmp;
}

// Output Element
var ds_oe = ds_getel('ds_calclass');
// Container
var ds_ce = ds_getel('ds_conclass');

// Output Buffering
var ds_ob = ''; 
function ds_ob_clean() {
	ds_ob = '';
}
function ds_ob_flush() {
	ds_oe.innerHTML = ds_ob;
	ds_ob_clean();
}
function ds_echo(t) {
	ds_ob += t;
}

var ds_element; // Text Element...

var ds_monthnames = [
'January', 'February', 'March', 'April', 'May', 'June',
'July', 'August', 'September', 'October', 'November', 'December'
]; // You can translate it for your language.

var ds_daynames = [
'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
]; // You can translate it for your language.

// Calendar template
function ds_template_main_above(t) {

    if(clear_button==null)
	{    
	
	    
	    if(time_button==null)
	    {  
	    
	    return '<table cellpadding="3" cellspacing="1" class="ds_tbl">'
	     + '<tr>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_py();">&lt;&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_pm();">&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_hi();" colspan="3">Close</td>'
	     + '<td class="ds_head" style="cursor: pointer" onclick="ds_nm();">&gt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_ny();">&gt;&gt;</td>'
		 + '</tr>'
	     + '<tr>'
		 + '<td colspan="7" class="ds_head">' + t + '</td>'
		 + '</tr>'
		 + '<tr>';
    
	    
	    
	    
	    
	    }
	    else
	    
	    { return '<table cellpadding="3" cellspacing="1" class="ds_tbl">'
	     + '<tr>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_py();">&lt;&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_pm();">&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_hi();" colspan="3">[Close]</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_nm();">&gt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_ny();">&gt;&gt;</td>'
		 + '</tr>'
		 + '<tr>'
		 + '<td colspan="3" class="ds_head">' + t + '</td>'
		 + '<td  colspan="4" class="ds_head"><select name="hours" id="hours"><option value="00">hh</option><option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option></select>'
		 + minute_string
		 + seconds_string
		 + '</td>'
		 + '</tr>'
		 + '<tr>';
		 }
		 
		 
		 
		 
		 }
		 
    else{
      
      
       if(time_button==null)
       
      { return '<table cellpadding="3" cellspacing="1" class="ds_tbl">'
	     + '<tr>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_py();">&lt;&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_pm();">&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_hi();" colspan="2">Close</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_hi_clear_text();">Clear</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_nm();">&gt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_ny();">&gt;&gt;</td>'
		 + '</tr>'
	     + '<tr>'
		 + '<td colspan="7" class="ds_head">' + t + '</td>'
		 + '</tr>'
		 + '<tr>';}
		 
		 
	  else{
	     return '<table cellpadding="3" cellspacing="1" class="ds_tbl">'
	     + '<tr>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_py();">&lt;&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_pm();">&lt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_hi();" colspan="2">Close</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_hi_clear_text();">Clear</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_nm();">&gt;</td>'
		 + '<td class="ds_head" style="cursor: pointer" onclick="ds_ny();">&gt;&gt;</td>'
		 + '</tr>'
	     + '<tr>'
		 + '<td colspan="3" class="ds_head">' + t + '</td>'
		 + '<td  colspan="4" class="ds_head"><select name="hours" id="hours"><option value="00">hh</option><option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option></select>'
		 + minute_string
		 + seconds_string
		 + '</tr>'
		 + '<tr>';
	  
	      }
    
       }
}

function ds_template_day_row(t) {
	return '<td class="ds_subhead">' + t + '</td>';
	// Define width in CSS, XHTML 1.0 Strict doesn't have width property for it.
}

function ds_template_new_week() {
	return '</tr><tr>';
}

function ds_template_blank_cell(colspan) {
	return '<td class="ds_cell1" colspan="' + colspan + '"></td>'
}

function ds_template_day(d, m, y) {
      
   
    if(current_date==d && current_month==m && current_year==y) 
    
	{return '<td class="ds_cell" onclick="ds_onclick(' + d + ',' + m + ',' + y + ')"> <font color="red"><i>' + d + '</i></font></td>';}
	
	else if (select_date==d)
	{
	return '<td class="ds_cell" onclick="ds_onclick(' + d + ',' + m + ',' + y + ')"> <font color="blue"><b>' + d + '</b></font></td>';
	
	}
	
	
	else
	
	{return '<td class="ds_cell" onclick="ds_onclick(' + d + ',' + m + ',' + y + ')"> ' + d + '</td>';}
	// Define width the day row.
}

function ds_template_main_below() {
	return '</tr>'
	     + '</table>';
}

// This one draws calendar...
function ds_draw_calendar(m, y) {
	// First clean the output buffer.
	ds_ob_clean();
	// Here we go, do the header
	ds_echo (ds_template_main_above(ds_monthnames[m - 1] + ' ' + y));
	for (i = 0; i < 7; i ++) {
		ds_echo (ds_template_day_row(ds_daynames[i]));
	}
	// Make a date object.
	var ds_dc_date = new Date();
	ds_dc_date.setMonth(m - 1);
	ds_dc_date.setFullYear(y);
	if (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
		days = 31;
		ds_dc_date.setDate(1);
	} else if (m == 4 || m == 6 || m == 9 || m == 11) {
		days = 30;
		ds_dc_date.setDate(1);
	} else {
		days = (y % 4 == 0) ? 29 : 28;
		ds_dc_date.setDate(0);
	}
	var first_day = ds_dc_date.getDay();
	var first_loop = 1;
	// Start the first week
	ds_echo (ds_template_new_week());
	// If sunday is not the first day of the month, make a blank cell...
	if (first_day != 0) {
		ds_echo (ds_template_blank_cell(first_day));
	}
	var j = first_day;
	for (i = 0; i < days; i ++) {
		// Today is sunday, make a new week.
		// If this sunday is the first day of the month,
		// we've made a new row for you already.
		if (j == 0 && !first_loop) {
			// New week!!
			ds_echo (ds_template_new_week());
		}
		// Make a row of that day!
		ds_echo (ds_template_day(i + 1, m, y));
		// This is not first loop anymore...
		first_loop = 0;
		// What is the next day?
		j ++;
		j %= 7;
	}
       if(j!=0)
	 {
	  
	   ds_echo (ds_template_blank_cell(7-j));
	   
	 
	 }
	// Do the footer
	ds_echo (ds_template_main_below());
	// And let's display..
	ds_ob_flush();
	// Scroll it into view.
	ds_ce.scrollIntoView();
}

// A function to show the calendar.
// When user click on the date, it will set the content of t.
function ds_sh1(t,ff) {
    var w=ff;
   // alert("dd");
   
   
     //alert(gg);
	// Set the element to set...
	ds_element = t;
	// Make a new date, and set the current month and year.
	var ds_sh_date = new Date();
	ds_c_month = ds_sh_date.getMonth() + 1;
	ds_c_year = ds_sh_date.getFullYear();
	var smonth;
    var emonth;
    var sdate;
    

   


   // alert(zz);
	var sd=new String(w);
    
       if (sd.substring(0,1) == 0) {
	  	sdate = parseInt(sd.substring(1, 2));
	  }
	  else {
	  	 sdate = parseInt(sd.substring(0, 2));
	  }
        
         select_date=sdate;
        
         
     
    if (sd.substring(3,4) == 0) {
	 
	  	smonth = parseInt(sd.substring(4, 5));
	  	
	  }
	  else {
	  	smonth = parseInt(sd.substring(3, 5));
	  }
	  
	  var syear=parseInt(sd.substring(6,10));
	 
	  ds_c_month=smonth;
	  ds_c_year=syear;
    
    
	   
	    //alert(eyear);
	
	//ds_c_month=7;
	//ds_c_year =2010;
	// Draw the calendar
	ds_draw_calendar(ds_c_month, ds_c_year);
	// To change the position properly, we must show it first.
	ds_ce.style.display = '';
	// Move the calendar container!
	the_left = ds_getleft(t);
	the_top = ds_gettop(t) + t.offsetHeight;
	ds_ce.style.left = the_left + 'px';
	ds_ce.style.top = the_top + 'px';
	// Scroll it into view.
	ds_ce.scrollIntoView();
}


function ds_sh(t,t_id,c_button,t_button) {
     var text_field_value=document.getElementById(t_id).value;
     textbox_id=t_id;
     clear_button=c_button;
     time_button=t_button;
     
     if(time_button==null)
     {time_button=null;}
     
     else
     {
       if(time_button=="YES")
       {time_button="YES";}
       
       else{time_button=null;}
     }
     if(clear_button==null)
     {clear_button=null;}
     
     else
     {
       if(clear_button=="YES")
       {clear_button="YES";}
       
       else{clear_button=null;}
     }
     var gdate=new Date();
     current_date=gdate.getDate();
     current_month=gdate.getMonth() +1;
     current_year=gdate.getFullYear();
     
     //alert(gg);
	// Set the element to set...
	ds_element = t;
	// Make a new date, and set the current month and year.
	var ds_sh_date = new Date();
	ds_c_month = ds_sh_date.getMonth() + 1;
	ds_c_year = ds_sh_date.getFullYear();
	select_date=100;
    
    if(text_field_value != "")
    {  var sdate;
       var smonth;
       w=text_field_value;
       var sd=new String(w);
      
       if (sd.substring(8,9) == 0) {
	  	sdate = parseInt(sd.substring(9, 10));
	  }
	  else {
	  	 sdate = parseInt(sd.substring(8, 10));
	  }
        
         select_date=sdate;
        
         
     
    if (sd.substring(5,6) == 0) {
	 
	  	smonth = parseInt(sd.substring(6, 7));
	  	
	  }
	  else {
	  	smonth = parseInt(sd.substring(5, 7));
	  }
	  
	  var syear=parseInt(sd.substring(0,4));
	 
	  ds_c_month=smonth;
	  ds_c_year=syear;
    
    
    
    }
    
    
    
	//ds_c_year =2010;
	// Draw the calendar
	ds_draw_calendar(ds_c_month, ds_c_year);
	// To change the position properly, we must show it first.
	ds_ce.style.display = '';
	// Move the calendar container!
	the_left = ds_getleft(t);
	the_top = ds_gettop(t) + t.offsetHeight;
	ds_ce.style.left = the_left + 'px';
	ds_ce.style.top = the_top + 'px';
	// Scroll it into view.
	ds_ce.scrollIntoView();
}

// Hide the calendar.
function ds_hi() {
	ds_ce.style.display = 'none';
}

// Moves to the next month...
function ds_nm() {
	// Increase the current month.
	ds_c_month ++;
	// We have passed December, let's go to the next year.
	// Increase the current year, and set the current month to January.
	if (ds_c_month > 12) {
		ds_c_month = 1; 
		ds_c_year++;
	}
	// Redraw the calendar.
	ds_draw_calendar(ds_c_month, ds_c_year);
}

// Moves to the previous month...
function ds_pm() {
	ds_c_month = ds_c_month - 1; // Can't use dash-dash here, it will make the page invalid.
	// We have passed January, let's go back to the previous year.
	// Decrease the current year, and set the current month to December.
	if (ds_c_month < 1) {
		ds_c_month = 12; 
		ds_c_year = ds_c_year - 1; // Can't use dash-dash here, it will make the page invalid.
	}
	// Redraw the calendar.
	ds_draw_calendar(ds_c_month, ds_c_year);
}

// Moves to the next year...
function ds_ny() {
	// Increase the current year.
	ds_c_year++;
	// Redraw the calendar.
	ds_draw_calendar(ds_c_month, ds_c_year);
}

// Moves to the previous year...
function ds_py() {
	// Decrease the current year.
	ds_c_year = ds_c_year - 1; // Can't use dash-dash here, it will make the page invalid.
	// Redraw the calendar.
	ds_draw_calendar(ds_c_month, ds_c_year);
}

// Format the date to output.
function ds_format_date(d, m, y) {
     var hour_text_value;
     var minute_text_value;
     var seconds_text_value;
     if( time_button!= null && time_button=="YES")
     
     {
     hour_text_value=document.getElementById('hours').value;
     minute_text_value=document.getElementById('minutes').value;
     seconds_text_value=document.getElementById('seconds').value;
     }
	// 2 digits month.
	m2 = '00' + m;
	m2 = m2.substr(m2.length - 2);
	// 2 digits day.
	d2 = '00' + d;
	d2 = d2.substr(d2.length - 2);
	// YYYY-MM-DD
	if( time_button!= null && time_button=="YES")
	{return y + '-' + m2 + '-' + d2+" "+hour_text_value+":"+minute_text_value+":"+seconds_text_value;}
	else
	{return y + '-' + m2 + '-' + d2;}
}

// When the user clicks the day.
function ds_onclick(d, m, y) {
  
	// Hide the calendar.
	ds_hi();
	
	
	// Set the value of it, if we can.
   if (textbox_id == null)
   {
   	   if (typeof(ds_element.value) != 'undefined') {
	       //document.getElementById(textbox_id).value=ds_format_date(d, m, y);
		  ds_element.value = ds_format_date(d, m, y);
	       // Maybe we want to set the HTML in it.
	   } else if (typeof(ds_element.innerHTML) != 'undefined') {
	       // document.getElementById(textbox_id).value=ds_format_date(d, m, y);
		  ds_element.innerHTML = ds_format_date(d, m, y);
	   // I don't know how should we display it, just alert it to user.
	   } else {
	     
	     alert (ds_format_date(d, m, y));
	   }

    }
    else {
        document.getElementById(textbox_id).value=ds_format_date(d, m, y);
    }
}
// And here is the end.

// ]]> -->
function ds_hi_clear_text() {
  
	// Hide the calendar.
	ds_hi();
	
	
	// Set the value of it, if we can.
   if (textbox_id == null)
   {
   	   if (typeof(ds_element.value) != 'undefined') {
	       //document.getElementById(textbox_id).value=ds_format_date(d, m, y);
		  ds_element.value = "";
	       // Maybe we want to set the HTML in it.
	   } else if (typeof(ds_element.innerHTML) != 'undefined') {
	       // document.getElementById(textbox_id).value=ds_format_date(d, m, y);
		  ds_element.innerHTML = "";
	   // I don't know how should we display it, just alert it to user.
	   } else {
	     
	     alert (ds_format_date(d, m, y));
	   }

    }
    else {
        document.getElementById(textbox_id).value="";
    }
}
// And here is the end.

// ]]> -->

