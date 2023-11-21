namespace nobody.core
{
    /// <summary>
    /// Ctx is the context that keeps track of state while calling fluent functions
    /// Ctx can be used within any fluent function to get or set variables, functions, etc.
    /// </summary>
    public class Ctx
    {
        private Dictionary<string,object> Variables { get; set; } = new Dictionary<string, object>();
        private Dictionary<string,Func<object[],object>> Functions { get; set; } = new Dictionary<string, Func<object[], object>>();
    
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
                    return null;
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
                    Variables.Add(key,value);
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

        public void set(string key, Func<object[],object> func)
        {
            if (Functions.ContainsKey(key))
            {
                Functions[key] = func;
            }
            else
            {
                Functions.Add(key,func);
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
                Variables.Add(key,value);
            }
        }

        public object get(string key)
        {
            if (Variables.ContainsKey(key))
            {
                return Variables[key];
            }
            else
            {
                return null;
            }
        }

        public bool has(string key)
        {
            return Variables.ContainsKey(key);
        }

        public bool hasFunction(string key)
        {
            return Functions.ContainsKey(key);
        }

        public bool hasVariable(string key)
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

        public void removeFunction(string key)
        {
            if (Functions.ContainsKey(key))
            {
                Functions.Remove(key);
            }
        }

        public void removeVariable(string key)
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

        public void clearFunctions()
        {
            Functions.Clear();
        }

        public void clearVariables()
        {
            Variables.Clear();
        }


    }

    

   
}