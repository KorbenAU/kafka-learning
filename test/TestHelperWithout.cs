using System.Reflection;
using Xunit.Sdk;

namespace UnitTests.TestHelper
{
    public class PrepareBatchFileWithouOffset : BeforeAfterTestAttribute
    {
        public readonly string _currentFolder;
        public readonly string _rootFolder;

        public PrepareBatchFileWithouOffset(string rootFolder)
        {
            _currentFolder = Directory.GetCurrentDirectory();
            _rootFolder = Path.Combine(_currentFolder, _rootFolder);
        }

        public override void Before(MethodInfo methodUnderTest)
        {
            CleanUpMockFolders();

            PrepareRequestFiles();

            base.Before(methodUnderTest);
        }

        public override void After(MethodInfo methodUnderTest)
        {
            CleanUpMockFolders();

            base.After(methodUnderTest);
        }

        private void PrepareRequestFiles()
        {
            FileHelper.CopyFiles(Constants.TestDataFolder, _rootFolder);
        }

        private void CleanUpMockFolders()
        {
            FileHelper.ClearFolder(_rootFolder);
        }
    }
}
