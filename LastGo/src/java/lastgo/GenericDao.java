/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package lastgo;
import org.hibernate.SessionFactory;
import org.hibernate.Session;

/**
 *
 * @author mourelatosm
 */
public class GenericDao
{

    public void save(Object object)
      {
        SessionFactory  factory = HibernateUtil.getSessionFactory();
        Session sess = factory.getCurrentSession();
        try
        {
            sess.beginTransaction();
            sess.save(object);
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
  }
}
