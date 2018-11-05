package websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
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
import org.springframework.stereotype.Component;


/*Going to need to switch this from messaging to notifications*/
@ServerEndpoint("/websocket/{username}")
@Component
public class WebSocketServer {
	//Code for notifications here
	
	
	
	
	
	
	
	
	/*private Session session;
    private static Set<WebSocketServer> chatEndpoints = new CopyOnWriteArraySet<>();
    private static Map<String, String> users = new HashMap();
    private final Logger logger = LoggerFactory.getLogger(WebSocketServer.class);
    
    @OnOpen
    public void onOpen(Session session, @PathParam("username") String username) throws IOException {
        logger.info("Entered into Open");
		this.session = session;
        chatEndpoints.add(this);
        users.put(session.getId(), username);
        
        String message="User:" + username +"Has Joined the Chat";
        	broadcast(message);
		
    }
 
    @OnMessage
    public void onMessage(Session session, String message) throws IOException {
        // Handle new messages
    	logger.info("Entered into Message: Got Message:"+message);
    	String echo="This is the received Text:"+message;
    	sendMessageToPArticularUser(session,echo);
    	//broadcast(message);
    }
 
    @OnClose
    public void onClose(Session session) throws IOException{
    	logger.info("Entered into Close");
        chatEndpoints.remove(this);
        String message="Disconnected";
        broadcast(message);
    }
 
    @OnError
    public void onError(Session session, Throwable throwable) {
        // Do error handling here
    	logger.info("Entered into Error");
    }
    
    private void sendMessageToPArticularUser(Session session,String message) {
    	try {
            session.getBasicRemote().sendText(message);
        } catch (IOException e) {
        	logger.info("Exception: " + e.getMessage().toString());
            e.printStackTrace();
        }
    }
    
    private static void broadcast(String message) throws IOException {
    	  chatEndpoints.forEach(endpoint -> {
    		  synchronized (endpoint) {
    			  try {
    				  endpoint.session.getBasicRemote().sendText(message);
    	          } catch (IOException e) {
    	              e.printStackTrace();
    	          }
    	       }
    	    });
    }*/
}
