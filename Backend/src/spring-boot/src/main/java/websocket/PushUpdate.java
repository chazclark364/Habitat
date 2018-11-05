package websocket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 *   Class that is called by the MYSQL database to call the method to update the
 *   needed users about an update in the MYSQL database.
 */
@WebServlet("/push-update")
public class PushUpdate extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		WebSocketServer.sendRequestUpdate(0);//Send update from DB
	}
}
