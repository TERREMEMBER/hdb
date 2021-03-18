package DataMining_RoughSets;

/**
 * ´Ö²Ú¼¯Ô¼¼òËã·¨
 */
public class Client {
	public static void main(String[] args){
		String filePath = "C:\\Users\\lyq\\Desktop\\icon\\input.txt";
		
		RoughSetsTool tool = new RoughSetsTool(filePath);
		tool.findingReduct();
	}
}
