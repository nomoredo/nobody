namespace nothing;

///# nowhere
/// a file based secret store that stores and retrieves secrets from files
/// uses protobuf to serialize and deserialize the secrets
public interface INothing
{
    public string Key { get;  }
}