<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String msg = (String)request.getAttribute("msg"); 
String addr = (String) request.getAttribute("addr");


%>

<script type="text/javascript">
alert('<%=msg%>');

<!-- 
location.href="/<%=addr %>"  // 페이지 이동...   
--> 
</script>