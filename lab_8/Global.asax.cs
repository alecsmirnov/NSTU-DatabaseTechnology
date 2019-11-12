using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Routing;


namespace DB_queries {
    public class Global : System.Web.HttpApplication {
        void RegisterRoutes(RouteCollection routes) {
            routes.MapPageRoute(null, "Task1", "~/Task1.aspx");
            //routes.MapPageRoute(null, "Task2", "~/Task2.aspx");
        }

        protected void Application_Start(object sender, EventArgs e) {
            RegisterRoutes(RouteTable.Routes);
        }

        protected void Session_Start(object sender, EventArgs e) {}
        protected void Application_BeginRequest(object sender, EventArgs e) {}
        protected void Application_AuthenticateRequest(object sender, EventArgs e) {}
        protected void Application_Error(object sender, EventArgs e) {}
        protected void Session_End(object sender, EventArgs e) {}
        protected void Application_End(object sender, EventArgs e) {}
    }
}