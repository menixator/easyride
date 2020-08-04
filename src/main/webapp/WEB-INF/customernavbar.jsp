<%@page import="com.easyride.models.User"%>
<%@page import="com.easyride.utils.EasyCabSession"%>
<%
    EasyCabSession customerNavbarAppSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
    User customerNavbarUser = customerNavbarAppSession.getUser();
%> 
<nav class="navbar navbar-expand-lg navbar-dark bg-dark d-flex">
    <div class="d-flex flex-grow-1">
        <span class="w-100 d-lg-none d-block"></span>
        <a class="navbar-brand d-none d-lg-inline-block" href="#">
            EasyRide
        </a>
    </div>
    <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
            <a class="nav-link" href="/customer/request-a-pickup.jsp">Request A Pickup<span class="sr-only">(current)</span></a>
        </li>
    </ul>
    <div class="collapse navbar-collapse text-right align-items-end flex-column">
        <div class="d-flex">
            <span class="navbar-text pr-2">
                Logged in as <%=customerNavbarUser.getName()%>
            </span>

            <form class="form-inline my-2 my-lg-0" method="POST" action="/logout">
                <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">Logout</button>
            </form>
        </div>

    </div> 
</nav>