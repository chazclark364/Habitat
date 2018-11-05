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
import org.springframework.stereotype.Component;


/*Going to need to switch this from messaging to notifications*/
@ServerEndpoint("/websocket/{username}")
@Component
public class WebSocketServer {
	private static Map<Session, String> sessionUsernameMap = new HashMap<>();
    private static Map<String, Session> usernameSessionMap = new HashMap<>();
	
	@OnOpen
	public void onOpen(Session session, @PathParam("username") String username) throws IOException{
		sessionUsernameMap.put(session, username);
        usernameSessionMap.put(username, session);

	}
	
	@OnClose
	public void onClose(Session session) throws IOException{
		String username = sessionUsernameMap.get(session);
    	sessionUsernameMap.remove(session);
    	usernameSessionMap.remove(username);
	}
	
	/*
	 *   Method used by the PushUpdate class to send a Push alert
	 *   to members associated with a request that has been updated
	 *   in the MYSQL database.
	 */
	public static void sendRequestUpdate(Integer assoiciatedID){
		synchronized (usernameSessionMap) {
			/*for (Map maps : usernameSessionMap) {
                if (maps.isOpen()) {//Change to user ID stuff
                    
                }
            }*/
		}
	}
	
}
