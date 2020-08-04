<%@page import="com.easyride.models.User"%>
<%@page import="com.easyride.utils.EasyCabSession"%>
<%
    EasyCabSession adminNavBarSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
    User adminNavbarUser = adminNavBarSession.getUser();
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
            <a class="nav-link" href="/admin/ridelist.jsp">Ride List</a>
        </li>
        <li class="nav-item active">
            <a class="nav-link" href="/admin/customerlist.jsp">Customer List</a>
        </li>
        <li class="nav-item active">
            <a class="nav-link" href="/admin/adminlist.jsp">Admin List</a>
        </li>
        <li class="nav-item active">
            <a class="nav-link" href="/admin/driverlist.jsp">Driver List</a>
        </li>
        <li class="nav-item active">
            <a class="nav-link" href="/admin/registerdriver.jsp">Register Driver</a>
        </li>
        <li class="nav-item active">
            <a class="nav-link" href="/admin/registeradmin">Register Admin</a>
        </li>
    </ul>
    <div class="collapse navbar-collapse text-right align-items-end flex-column">
        <div class="d-flex">
            <span class="navbar-text pr-2">
                Logged in as <%=adminNavbarUser.getName()%>
            </span>

            <form class="form-inline my-2 my-lg-0" method="POST" action="/logout">
                <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">Logout</button>
            </form>
        </div>

    </div> 
</nav>