using ProtoBuf;

namespace nothing;

[ProtoContract(InferTagFromName = true)]
public class Credentials : INothing
{

    public string Username { get; set; }
    public string Password { get; set; }
    [ProtoIgnore]
    public string Key => Username.ToLower();
}