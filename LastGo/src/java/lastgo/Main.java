/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package lastgo;

import java.util.List;

/**
 *
 * @author mourelatosm
 */
public class Main {

   public static void main(String [] args) {


        User user3;

        //RegisterManager rm = new RegisterManager();
        //User user = rm.addUser();
        //User user1 = rm.takeUser();
        UserDao dao = new UserDao();
        User user2 = new User("marios", "6209", "mourelatosm@gmail.com");
        //Room room1 = new Room("thallasa", "souita", 3);
        //dao.save(room1);
        //List<User> users = dao.getAllUsers();
        //rm.autheUser();
        //dao.update(user2);
        dao.save(user2);
        List<User> userlist = dao.getAllUsers();

        String iusername, ipassword;

        iusername=user2.getUsername();
        ipassword=user2.getPassword();

        String username, password;

        for(User user : userlist)
        {
            username = user.getUsername();
            password = user.getPassword();
            if(iusername.equals(username) && ipassword.equals(password) )
            {
                System.out.println("bravo ekanes login");
            }
            else
            {
                System.out.println("Lipame den eise katagegramenos sthn vash");
            }
        }

        user3 = dao.getById(69);

        dao.deleteById(65);


        user3.setUsername("sofoklis");

        dao.update(user3);







      //User user2 = rm.autheUser();

      // System.out.println("Id of user is: " + user.getId());
      // System.out.println("Name of user is: " + user.getUsername());
      // System.out.println("Password of user is: " + user.getPassword());

      // System.out.println("heeeeeiiiiii");





    }

}