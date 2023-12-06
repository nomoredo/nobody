using Serilog;

namespace nobody.core;

public abstract class Anybody
{
    public static Anybody here => AnybodySingle.here;
    public static Ctx ctx => here._ctx;
    protected Ctx _ctx = new Ctx();
    public static ILogger log => here._log;
    protected ILogger _log = Log.ForContext<Anybody>();


     protected Anybody()
     {

     }

     public T? get<T>(string key) => _ctx.get<T>(key);
     public bool has(string key) => _ctx.has(key);
     public void set(string key, object? value) => _ctx.set(key, value);

     public T get_or<T>(string key, Func<string, T> defaultValue) => _ctx.get_or(key, defaultValue);
     public string get_string(string key) => _ctx.get_string(key);
     public string get_string(string key, string defaultValue) => _ctx.get_string(key, defaultValue);

}

 static class AnybodySingle
{
    public static Anybody here => _here ??= new Nobody();
    private static Anybody? _here;
}