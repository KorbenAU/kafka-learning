using System.Reflection;
using Xunit.Sdk;

namespace UnitTests.TestHelper
{
    public class PrepareBatchFileWithOffset : BeforeAfterTestAttribute
    {
        public readonly string _currentFolder;
        public readonly string _rootFolder;

        public PrepareBatchFileWithOffset(string rootFolder)
        {
            _currentFolder = Directory.GetCurrentDirectory();
            _rootFolder = Path.Combine(_currentFolder, _rootFolder);
        }

        public override void Before(MethodInfo methodUnderTest)
        {
            CleanUpMockFolders();

            PrepareRequestFiles();

            PrepareOffsetFile();

            base.Before(methodUnderTest);
        }

        public override void After(MethodInfo methodUnderTest)
        {
            CleanUpMockFolders();

            base.After(methodUnderTest);
        }

        private void PrepareOffsetFile()
        {
            FileHelper.CopyFiles(Constants.TestOffsetFolder, _rootFolder);
        }

        private void PrepareRequestFiles()
        {
            FileHelper.CopyFiles(Constants.TestDataFolder, Path.Combine(_rootFolder, Constants.BatchFileFolderName));
        }

        private void CleanUpMockFolders()
        {
            FileHelper.ClearFolder(_rootFolder);
        }
    }
}
