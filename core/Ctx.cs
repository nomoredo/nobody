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

        public object? this[string key]
        {
            get
            {
                if (Variables.TryGetValue(key, out var item))
                {
                    return item;
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
                    if (value == null)
                    {
                        Variables.Remove(key);
                    }
                    else
                    {
                        Variables[key] = value;
                    }
                }
                else
                {
                    if (value != null)
                    {
                        Variables.Add(key, value);
                    }
                }
            }
        }


        public void set(string key, object? value)
        {
            if (Variables.ContainsKey(key) )
            {
                if (value == null)
                {
                    Variables.Remove(key);
                }
                else
                {
                    Variables[key] = value;
                }
            }
            else
            {
                if (value != null)
                {
                    Variables.Add(key, value);
                }
            }
        }

        public T? get<T>(string key)
        {
            if (Variables.TryGetValue(key, out var variable))
            {
                return (T)variable;
            }
            else
            {
                return default(T);
            }
        }

        public T get_or<T>(string key, Func<string, T> defaultValue)
        {
            if (Variables.TryGetValue(key, out var variable))
            {
                return (T)variable;
            }
            else
            {
                return defaultValue(key);
            }
        }




        public String get_string(string key)
        {
            if (Variables.TryGetValue(key, out var variable))
            {
                return (String)variable;
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
    }
}

