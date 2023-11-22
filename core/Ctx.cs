using nobody.core;
using Serilog.Events;

namespace nobody.core
{
    /// <summary>
    /// Ctx is the context that keeps track of state while calling fluent functions
    /// Ctx can be used within any fluent function to get or set variables, functions, etc.
    /// </summary>
    public class Ctx
    {
        private Func<string, object>? AskHandler { get; set; }
        private Dictionary<string, object> Variables { get; set; } = new Dictionary<string, object>();

        private Dictionary<string, Func<object[], object>> Functions { get; set; } =
            new Dictionary<string, Func<object[], object>>();

        private Dictionary<string, AnyPlugin> services = new Dictionary<string, AnyPlugin>();


        public Ctx()
        {
        }

        public Ctx(Func<string, object> askHandler)
        {
            AskHandler = askHandler;
        }

        public void HandleVariableNotAvailable(Func<string, object> askFor)
        {
            AskHandler = askFor;
        }

        public object this[string key]
        {
            get
            {
                if (Variables.ContainsKey(key))
                {
                    return Variables[key];
                }
                else
                {
                    return AskHandler?.Invoke(key);
                }
            }
            set
            {
                if (Variables.ContainsKey(key))
                {
                    Variables[key] = value;
                }
                else
                {
                    Variables.Add(key, value);
                }
            }
        }

        public object call(string key, params object[] args)
        {
            if (Functions.ContainsKey(key))
            {
                return Functions[key](args);
            }
            else
            {
                return null;
            }
        }

        public void set(string key, Func<object[], object> func)
        {
            if (Functions.ContainsKey(key))
            {
                Functions[key] = func;
            }
            else
            {
                Functions.Add(key, func);
            }
        }

        public void set(string key, object value)
        {
            if (Variables.ContainsKey(key))
            {
                Variables[key] = value;
            }
            else
            {
                Variables.Add(key, value);
            }
        }

        public T get<T>(string key)
        {
            if (Variables.ContainsKey(key))
            {
                return (T)Variables[key];
            }
            else
            {
                return default(T);
            }
        }

        public String get_string(string key)
        {
            if (Variables.ContainsKey(key))
            {
                return (String)Variables[key];
            }
            else
            {
                return "";
            }
        }

        public bool has(string key)
        {
            return Variables.ContainsKey(key);
        }


        public void remove(string key)
        {
            if (Variables.ContainsKey(key))
            {
                Variables.Remove(key);
            }
        }


        public void clear()
        {
            Variables.Clear();
            Functions.Clear();
        }

        public Ctx register(string key, AnyPlugin service)
        {
           if (services.ContainsKey(key))
            {
                services[key] = service;
            }
            else
            {
                services.Add(key, service);
            }
            return this;
        }

        public T service<T>(string key) where T : AnyPlugin
        {
            if (services.ContainsKey(key))
            {
                return (T)services[key];
            }
            else
            {
                return default(T);
            }
        }

        public T? maybe_service<T>(string key) where T : AnyPlugin
        {
            if (services.ContainsKey(key))
            {
                return (T)services[key];
            }
            else
            {
                return default(T);
            }
        }

        public void cleanup()
        {
            services.Clear();
        }
    }
}

public class NoLog : AnyLogger
{
    public void Write(LogEvent logEvent)
    {
    }

    public void register(Nobody nobody)
    {
        nobody.ctx.register("logger", this);
    }

    public void cleanup(Nobody nobody)
    {
    }
}
