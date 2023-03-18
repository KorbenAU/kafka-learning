namespace UnitTests
{
    public static class Constants
    {
        //public static string CurrentFolder = Directory.GetCurrentDirectory();
        //public static string MockedBatchFileRootFolder = Path.Combine(Directory.GetCurrentDirectory(), "BatchFileFolder");
        //public static string MockedBatchFileFolder = Path.Combine(MockedBatchFileRootFolder, "Outbound");
        //public static string MockedProcessingFolder = Path.Combine(MockedBatchFileRootFolder, "processing");
        //public static string MockedProcessedFolder = Path.Combine(MockedBatchFileRootFolder, "processed");
        public static string TestDataFolder = Path.Combine(Directory.GetCurrentDirectory(), "NasShareMock\\TestData");
        public static string TestOffsetFolder = Path.Combine(Directory.GetCurrentDirectory(), "NasShareMock\\Offset");
        //public static string OffsetFile = Path.Combine(MockedBatchFileRootFolder, "offset.json");
        //public static string StatusFile = Path.Combine(MockedBatchFileRootFolder, "status.txt");
        public static string BatchFileFolderName = "Outbound";
    }
}
