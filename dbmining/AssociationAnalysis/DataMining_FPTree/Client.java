package DataMining_FPTree;

/**
 * FPTree频繁模式树算法
 *
 */
public class Client {
	public static void main(String[] args){
		//最小支持度阈值
		int minSupportCount = 2;
		
		FPTreeTool tool = new FPTreeTool(filePath, minSupportCount);
		tool.startBuildingTree();
	}
}
