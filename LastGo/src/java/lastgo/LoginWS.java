/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package lastgo;

import java.util.List;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

/**
 *
 * @author mourelatosm
 */
@WebService()
public class LoginWS
{

    String result;
    /**
     * Web service operation
     */
    @WebMethod(operationName = "sighnUpUser")
    public String sighnUpUser(
            @WebParam(name = "password") String password,
            @WebParam(name = "username") String username,
            @WebParam(name = "email") String email)
    {
        //TODO write your implementation code here:
        String dbusername, dbpassword, dbemail;


        UserDao dao = new UserDao();

        List<User> userlist = dao.getAllUsers();

        int i=0, j=0, k=0;

        for(User user : userlist)
        {
            dbusername = user.getUsername();
            //dbpassword = user.getPassword();
            dbemail = user.getEmail();

            if(dbusername.equals(username))
            {  
                i=1;
            }
       
            if(dbemail.equals(email))
            {
                j=1;
            }
            
              if(dbusername.equals(username) && dbemail.equals(email))
            {
                k=1;
            }
            System.out.println(i);
            System.out.println(j);
            System.out.println(k);
        }
 
        //System.out.println(i);
        //System.out.println(j);
        //System.out.println(k);

        if(i == 0 && j == 0)
        {
            User usr = new User(username, password, email);
            dao.save(usr);
            result = ("User:" +username+ " succesfully sighned up");
        }
        if(i == 1)
        {
            result = ("Your username  already exists");
        }
        if(j == 1)
        {
            result = ("Your email already exists");
        }
        if(k == 1)
        {
            result = ("It seems that you have already sighned up");
        }


        return result;
    }

}
