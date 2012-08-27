<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/resources/css/application.css'/>" />

<div class="body-centered">
	<h4>Social connection information</h4>	
	<p>Active connections:
	<ol>
	<c:forEach items="${providers }" var="provider">
		<li>${provider.key } as ${provider.value[0].displayName }</li>
	</c:forEach>
	</ol>
</div>