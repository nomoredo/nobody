//implementation of auto runner for [Runnable] attribute

using System.Reflection;
using nobody.core;

namespace nobody.echo;

public class TestRunner
{
    public static async Task RunAsync()
    {
        var types = Assembly.GetExecutingAssembly().GetTypes();
        foreach (var type in types)
        {
            var methods = type.GetMethods();
            foreach (var method in methods)
            {
                var attributes = method.GetCustomAttributes(typeof(RunnableAttribute), false);
                if (attributes.Length > 0)
                {
                    var instance = Activator.CreateInstance(type);
                    if (method.ReturnType == typeof(Task))
                    {
                        // If the method is asynchronous
                        await (Task)method.Invoke(instance, null);
                    }
                    else
                    {
                        // If the method is synchronous
                        method.Invoke(instance, null);
                    }
                }
            }
        }
    }
}

