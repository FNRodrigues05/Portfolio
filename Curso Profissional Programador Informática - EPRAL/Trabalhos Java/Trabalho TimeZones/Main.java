import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class Main
{

    public static void main(String[] args)
    {
        // TODO Auto-generated method stub

        ZonedDateTime data3 = ZonedDateTime.now(ZoneId.of("Asia/Jerusalem"));

        String final1 = DateTimeFormatter.ofPattern("dd/MM/yyyy - kk:mm:ss").format(data3);

        System.out.println("Israel - " + final1);

        ZonedDateTime data4 = ZonedDateTime.now(ZoneId.of("America/Costa_Rica"));

        String final2 = DateTimeFormatter.ofPattern("dd/MM/yyyy - kk:mm:ss").format(data4);

        System.out.println("Costa Rica - " + final2);

        ZonedDateTime data1 = ZonedDateTime.now(ZoneId.of("Asia/Tokyo"));

        String final3 = DateTimeFormatter.ofPattern("dd/MM/yyyy - kk:mm:ss").format(data1);

        System.out.println("Japão - " + final3);

        ZonedDateTime data2 = ZonedDateTime.now(ZoneId.of("Europe/Brussels"));

        String final4 = DateTimeFormatter.ofPattern("dd/MM/yyyy - kk:mm:ss").format(data2);

        System.out.println("Bélgica - " + final4);

        ZonedDateTime data = ZonedDateTime.now(ZoneId.of("Europe/Lisbon"));

        String final5 = DateTimeFormatter.ofPattern("dd/MM/yyyy - kk:mm:ss").format(data);

        System.out.println("Portugal - " + final5 + "\n");

        ZonedDateTime finall5 = ZonedDateTime.now(ZoneId.of("Europe/Lisbon"));

        ZonedDateTime finall3 = ZonedDateTime.now(ZoneId.of("Asia/Tokyo"));

        ZonedDateTime finall4 = ZonedDateTime.now(ZoneId.of("Europe/Brussels"));

        ZonedDateTime finall1 = ZonedDateTime.now(ZoneId.of("Asia/Jerusalem"));

        ZonedDateTime finall2 = ZonedDateTime.now(ZoneId.of("America/Costa_Rica"));

        if (finall1.isBefore(finall2))
        {
        }
        else if (finall1.isBefore(finall3))
        {
        }
        else if (finall1.isBefore(finall4))
        {
        }
        else if (finall1.isBefore(finall5))
        {
            System.out.println("\nIsrael é o pais mais cedo - " + final1);
        }

        if (finall1.isAfter(finall2))
        {
        }
        else if (finall1.isAfter(finall3))
        {
        }
        else if (finall1.isAfter(finall4))
        {
        }
        else if (finall1.isAfter(finall5))
        {
            System.out.println("\nIsrael é o pais mais tarde - " + final1);
        }

        if (finall2.isBefore(finall1))
        {
        }
        else if (finall2.isBefore(finall3))
        {
        }
        else if (finall2.isBefore(finall4))
        {
        }
        else if (finall2.isBefore(finall5))
        {
            System.out.println("\nCosta Rica é o pais mais cedo - " + final2);
        }

        if (finall2.isAfter(finall1))
        {
        }
        else if (finall2.isAfter(finall3))
        {
        }
        else if (finall2.isAfter(finall4))
        {
        }
        else if (finall2.isAfter(finall5))
        {
            System.out.println("\nCosta Rica é o pais mais tarde - " + final2);
        }

        if (finall3.isBefore(finall1))
        {
        }
        else if (finall3.isBefore(finall2))
        {
        }
        else if (finall3.isBefore(finall4))
        {
        }
        else if (finall3.isBefore(finall5))
        {
            System.out.println("\nJapão é o pais mais cedo - " + final3);
        }

        if (finall3.isAfter(finall1))
        {
        }
        else if (finall3.isAfter(finall2))
        {
        }
        else if (finall3.isAfter(finall4))
        {
        }
        else if (finall3.isAfter(finall5))
        {
            System.out.println("\nJapão é o pais mais tarde - " + final3);
        }

        if (finall4.isBefore(finall1))
        {
        }
        else if (finall4.isBefore(finall2))
        {
        }
        else if (finall4.isBefore(finall3))
        {
        }
        else if (finall4.isBefore(finall5))
        {
            System.out.println("\nBélgica é o pais mais cedo - " + final4);
        }

        if (finall4.isAfter(finall1))
        {
        }
        else if (finall4.isAfter(finall2))
        {
        }
        else if (finall4.isAfter(finall3))
        {
        }
        else if (finall4.isAfter(finall5))
        {
            System.out.println("\nBélgica é o pais mais tarde - " + final4);
        }

        if (finall5.isBefore(finall1))
        {
        }
        else if (finall5.isBefore(finall2))
        {
        }
        else if (finall5.isBefore(finall3))
        {
        }
        else if (finall5.isBefore(finall4))
        {
            System.out.println("\nPortugal é o pais mais cedo - " + final5);
        }

        if (finall5.isAfter(finall1))
        {
        }
        else if (finall5.isAfter(finall2))
        {
        }
        else if (finall5.isAfter(finall3))
        {
        }
        else if (finall5.isAfter(finall4))
        {
            System.out.println("\nPortugal é o pais mais tarde - " + final5);
        }

        System.out.println("\nCosta Rica é o pais mais cedo - " + final2);
    }
}