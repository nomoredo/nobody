using ProtoBuf;

namespace nothing;

///# nowhere
/// datastore
public class Nowhere
{

    public static async Task<DirectoryInfo> GetDir(string path)
    {
      //stores information in users home directory under .nowhere
      var home = Path.Join(Environment.GetFolderPath(Environment.SpecialFolder.UserProfile));
      var dir = new DirectoryInfo(Path.Join(home,".nowhere",path));
      if (!dir.Exists)
      {
          dir.Create();
      }

      return dir;
    }

    public static async Task<FileInfo> GetPath<T>(string file)  where T : INothing
    {
        var dir = await GetDir(typeof(T).Name);
        return await  Task.FromResult(new FileInfo(Path.Join(dir.FullName,file)));
    }

    public static async Task<T?> Get<T>(string key) where T : INothing
    {
        var path = await GetPath<T>(key);
        if (path.Exists)
        {
            using (var input = File.OpenRead(path.FullName))
            {
                return Decrypt<T>(Serializer.Deserialize<T>(input));
            }
        }

        return default;
    }



    public static async Task<bool> Store<T>(string key, T value) where T : INothing
    {
        //protobuf serialize the value
        var path = await GetPath<T>(key);
        using (var output = File.Create(path.FullName))
        {
            Serializer.Serialize(output, Encrypt(value));
        }

        return true;
    }

    public static T Encrypt<T>(T value) where T : INothing
    {
        return value;
    }

    public static T Decrypt<T>(T value) where T : INothing
    {
        return value;
    }

    public static async Task<bool> Delete<T>(string key) where T : INothing
    {
        var path = await GetPath<T>(key);
        if (path.Exists)
        {
            path.Delete();
        }

        return true;
    }


}