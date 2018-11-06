package websocket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;

/*
 *   Class that is called by the MYSQL database to call the method to update the
 *   needed users about an update in the MYSQL database.
 */
@WebServlet("/push-update/{requestID}")
public class PushUpdate extends HttpServlet{
	
	
	/*
	 *   Method is called by the MYSQL Database.
	 *   Gets the associated requestID that has changed in the database
	 *   Uses the WebSocketServer Send Request to send notification to proper users
	 */
	//@Override
	protected void doGet(@PathParam("requestID") Integer associatedID, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		WebSocketServer.sendRequestUpdate(associatedID);
	}
}
