/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package lastgo;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Criteria;

/**
 *
 * @author mourelatosm
 */
public class UserDao extends GenericDao {

    public User getById(int id)
    {

        User user = new User();


        SessionFactory  factory = HibernateUtil.getSessionFactory();
        Session sess = factory.getCurrentSession();

        try
        {
            sess.beginTransaction();
            user = (User) sess.get(User.class, id);
            sess.getTransaction().commit();
        }
        catch (Throwable e)
        {
                    if (sess.getTransaction().isActive())
                    {
                    sess.getTransaction().rollback();
                    }
                 System.out.println(e.getMessage());
        }


     System.out.println("Id of the selected user is: " + user.getId());
     System.out.println("Name of the selected user is: " + user.getUsername());
     System.out.println("Password of the selected user is: " + user.getPassword());

        return user;

    }


    public List getAllUsers()
    {
        SessionFactory  factory = HibernateUtil.getSessionFactory();
        Session sess = factory.getCurrentSession();

        List<User> userlist = null;

        try
        {
            sess.beginTransaction();
            Criteria criteria = sess.createCriteria(User.class);
            List<User> users = criteria.list();
            userlist = users;
                for(User user : users) {
                System.out.println("User id: " + user.getId() + " Username: " + user.getUsername());
                }
            sess.getTransaction().commit();
        }
        catch (Throwable e)
        {
                    if (sess.getTransaction().isActive())
                    {
                    sess.getTransaction().rollback();
                    }
                 System.out.println(e.getMessage());
        }

        return userlist;

    }


    public void deleteById(int id)
    {

        User user = new User();


        SessionFactory  factory = HibernateUtil.getSessionFactory();
        Session sess = factory.getCurrentSession();

        try
        {
            sess.beginTransaction();
            user = (User) sess.get(User.class, id);
            if(user!=null)
            {
                sess.delete(user);
            }
            sess.getTransaction().commit();
        }
        catch (Throwable e)
        {
                    if (sess.getTransaction().isActive())
                    {
                    sess.getTransaction().rollback();
                    }
                 System.out.println(e.getMessage());
        }

        if(user!=null)
        {
             System.out.println("Id of the deleted user is: " + user.getId());
             System.out.println("Name of the deleted user is: " + user.getUsername());
             System.out.println("Password of the deleted user is: " + user.getPassword());sess.delete(user);
        }





    }


    public User update(User user)
    {


        SessionFactory  factory = HibernateUtil.getSessionFactory();
        Session sess = factory.getCurrentSession();

        try
        {
            sess.beginTransaction();
            sess.merge(user);
            sess.getTransaction().commit();
        }
        catch (Throwable e)
        {
                    if (sess.getTransaction().isActive())
                    {
                    sess.getTransaction().rollback();
                    }
                 System.out.println(e.getMessage());
        }


     System.out.println("Id of the updated user is: " + user.getId());
     System.out.println("Name of the updated user is: " + user.getUsername());
     System.out.println("Password of the updated user is: " + user.getPassword());

     return user;

    }







  /*  public void update(User usr)
    {
        SessionFactory  factory = NewHibernateUtil.getSessionFactory();
        Session sess = factory.getCurrentSession();

            sess.beginTransaction();
            sess.merge(usr);
            sess.getTransaction().commit();
            sess.close();


    }

    public list<User> AllUsers()
    {
                SessionFactory  factory = NewHibernateUtil.getSessionFactory();
        Session sess = factory.getCurrentSession();

            sess.beginTransaction();
            sess.createQuery("from User")
            sess.getTransaction().commit();
            sess.close();
    }
   */









}
