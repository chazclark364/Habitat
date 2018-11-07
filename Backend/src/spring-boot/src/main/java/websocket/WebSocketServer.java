package websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.demo.RequestRepository;
import com.example.demo.Request;


/*Going to need to switch this from messaging to notifications*/
@ServerEndpoint("/websocket/{id_users}")
@Component
public class WebSocketServer {
	private static Map<Session, Integer> sessionUserIDMap = new HashMap<>(); //Session is Key, UserID is value
    private static Map<Integer, Session> userIDSessionMap = new HashMap<>(); //UserID is Key, Session is value
    private final Logger logger = LoggerFactory.getLogger(WebSocketServer.class);
    
    @Autowired
    private static RequestRepository requests;
    
	@OnOpen
	public void onOpen(Session session, @PathParam("id_users") Integer id_users) throws IOException{
		sessionUserIDMap.put(session, id_users);
        userIDSessionMap.put(id_users, session);
        logger.info("Session open: "+ id_users);
	}
	
	@OnClose
	public void onClose(Session session) throws IOException{
		Integer id_users = sessionUserIDMap.get(session);
    	sessionUserIDMap.remove(session);
    	userIDSessionMap.remove(id_users);
    	logger.info("Session closed: "+ id_users);
	}
	
	@OnError
    public void onError(Session session, Throwable throwable) 
    {
    	logger.info("Error occured");
    }

	/*
	 *   Method used by the PushUpdate class to send a Push alert
	 *   to members associated with a request that has been updated
	 *   in the MYSQL database.
	 */
	@OnMessage
	public void OnMessage(Session session, String request){
		
		//Request requestChanged = new Request();
		/*
		 *   The 2 different users to notify on an update to a request
		 */
		Integer notify1 = null;
		Integer notify2 = null;
		
		String[] information = request.split(",");
		
		notify1 = Integer.parseInt(information[0]);
		notify2 = Integer.parseInt(information[1]);
		String title = information[2];
		
		/*
		 *   Send notification to needed users with an open session
		 */
		if(notify1 != null && userIDSessionMap.get(notify1).isOpen()){//Send notification to 1st person
			sendMessageToPArticularUser(notify1, title);
		}
		
		if(notify2 != null && userIDSessionMap.get(notify2).isOpen()){//Send notification to 2nd person
			sendMessageToPArticularUser(notify2, title);
		}
		
		/*
		 *   Get the 3 different types of users from the request that has changed
		 */
		/*Integer lastUpdated = requestChanged.getLastUpdated();
		Integer requestee = requestChanged.getRequestee();
		Integer landlord = requestChanged.getLandlord();
		Integer worker = requestChanged.getWorker();*/
		
		/*
		 *   Determine the needed users to notify
		 */
		/*if(lastUpdated == requestee){
			 //
			 //  If the last update was the requestee and the landlord and requestee are
			 //  the same user, only alert the worker.  Else notify both the landlord and 
			 //  worker
			 //
			if(requestee == landlord){ 
				notify1 = worker;
			}else{
				notify1 = landlord;
				notify2 = worker;
			}
		}else if(lastUpdated == landlord){
			 //
			 //  If the last update was by the landlord, and the landlord and requestee are
			 //  the same user, only alert the worker.  Else notify both the requestee and 
			 //  worker
			 //
			if(requestee == landlord){
				notify1 = worker;
			}else{
				notify1 = requestee;
				notify2 = worker;
			}
		}else if(lastUpdated == worker){
			 //
			 //   If the last update was the worker and the requestee and landlord are 
			 //   the same, only notify the landlord.  Else notify both the requestee 
			 //   and landlord
			 //
			if(requestee == landlord){
				notify1 = landlord;
			}else{
				notify1 = requestee;
				notify2 = landlord;
			}
		}*/

	}
	
	private void sendMessageToPArticularUser(Integer username, String message) 
    {	
    	try {
    		userIDSessionMap.get(username).getBasicRemote().sendText(message + " has been updated");
    		System.out.println("Sent to " + username);
        } catch (IOException e) {
        	logger.info("Exception: " + e.getMessage().toString());
            e.printStackTrace();
        }
    }

	
	
}
