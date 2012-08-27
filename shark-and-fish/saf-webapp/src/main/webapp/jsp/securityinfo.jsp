<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/resources/css/application.css'/>" />

<div class="body-centered">
	<h4>Security information</h4>	
	<p>Granted Authorities:
	<ol>
	<c:forEach items="${authorities }" var="authority">
		<li>${authority.authority }</li>
	</c:forEach>
	</ol>
</div>