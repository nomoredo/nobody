namespace nobody.core;

public static class StringExtCtx
{
    public static bool has(this string s)
    {
        return Anybody.here.has(s);
    }

    public static T get<T>(this string s)
    {
        if (Anybody.here.has(s))
        {
            return Anybody.here.get<T>(s);
        }
        else
        {
            return Anybody.here.ask<T>(s);
        }
    }

    public static T get<T>(this string s, T defaultValue)
    {
        if (Anybody.here.has(s))
        {
            return Anybody.here.get<T>(s);
        }
        else
        {
            return Anybody.here.ask<T>(s, defaultValue);
        }
    }

    public static string get_string(this string s)
    {
        return Anybody.here.get_string(s);
    }

    public static string get_string(this string s, string defaultValue)
    {
        return Anybody.here.get_string(s, defaultValue);
    }

    //estensions on string
    public static T ask<T>(this string prompt)
    {
       return Anybody.here.ask<T>(prompt);
    }

    public static T ask<T>(this string prompt, T defaultValue)
    {
        return Anybody.here.ask<T>(prompt, defaultValue);
    }
}



