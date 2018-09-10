import java.text.SimpleDateFormat;
public class MrSimpleDateFormatParser
{
public static void main(String[] foAString)
throws Exception
{
	System.out.println(
		new SimpleDateFormat(foAString[0])
		.parse(foAString[1])
		);
}
}
