<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="../comm/header2.jsp" %>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span3" id="sidebar">
                    <ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
                        <li>
                            <a href="/adminMain"><i class="icon-chevron-right"></i> Dashboard</a>
                        </li>
                        <li class="active">
                            <a href="/adminCalendar"><i class="icon-chevron-right"></i> Calendar</a>
                        </li>
                        <li>
                            <a href="/adminChart"><i class="icon-chevron-right"></i> Charts</a>
                        </li>
                    </ul>
                </div>
                <!--/span-->
                <div class="span9" id="content">
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <div class="navbar navbar-inner block-header">
                                <div class="muted pull-left">Calendar</div>
                                <div class="pull-right"><span class="badge badge-warning">View More</span>

                                </div>
                            </div>
                            <div class="block-content collapse in">
                                <div class="span2">
                                    <div id='external-events'>
                                    <h4>Draggable Events</h4>
                                    <div class='external-event'>My Event 1</div>
                                    <div class='external-event'>My Event 2</div>
                                    <div class='external-event'>My Event 3</div>
                                    <div class='external-event'>My Event 4</div>
                                    <div class='external-event'>My Event 5</div>
                                    <div class='external-event'>My Event 6</div>
                                    <div class='external-event'>My Event 7</div>
                                    <div class='external-event'>My Event 8</div>
                                    <div class='external-event'>My Event 9</div>
                                    <div class='external-event'>My Event 10</div>
                                    <div class='external-event'>My Event 11</div>
                                    <div class='external-event'>My Event 12</div>
                                    <div class='external-event'>My Event 13</div>
                                    <div class='external-event'>My Event 14</div>
                                    <div class='external-event'>My Event 15</div>
                                    <p>
                                    <input type='checkbox' id='drop-remove' /> <label for='drop-remove'>remove after drop</label>
                                    </p>
                                    </div>

                                </div>
                                <div class="span10">
                                    <div id='calendar'></div>
                                </div>
                            </div>
                        </div>
                        <!-- /block -->
                    </div>
                </div>
            </div>
        </div>
</body>
</html>