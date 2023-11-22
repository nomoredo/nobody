namespace nobody.core;

public static class Set
{
    public static Ctx set(this Ctx ctx, string key, object value)
    {
        ctx[key] = value;
        return ctx;
    }

    public static Ctx set(this Ctx ctx, Dictionary<string, object> values)
    {
        foreach (var item in values)
        {
            ctx[item.Key] = item.Value;
        }
        return ctx;
    }

    public static Ctx set(this Ctx ctx, object value)
    {
        ctx["value"] = value;
        return ctx;
    }

    public static Ctx set(this Ctx ctx, params object[] values)
    {
        for (int i = 0; i < values.Length; i++)
        {
            ctx[i.ToString()] = values[i];
        }
        return ctx;
    }

    public static Ctx set(this Ctx ctx, Func<Ctx, object> value)
    {
        ctx["value"] = value(ctx);
        return ctx;
    }

    public static Ctx set(this Ctx ctx, string key, Func<Ctx, object> value)
    {
        ctx[key] = value(ctx);
        return ctx;
    }

    public static Ctx set(this Ctx ctx, Dictionary<string, Func<Ctx, object>> values)
    {
        foreach (var item in values)
        {
            ctx[item.Key] = item.Value(ctx);
        }
        return ctx;
    }

    public static Ctx set(this Ctx ctx, params Func<Ctx, object>[] values)
    {
        for (int i = 0; i < values.Length; i++)
        {
            ctx[i.ToString()] = values[i](ctx);
        }
        return ctx;
    }

    public static Ctx set(this Ctx ctx, string key, params Func<Ctx, object>[] values)
    {
        for (int i = 0; i < values.Length; i++)
        {
            ctx[key] = values[i](ctx);
        }
        return ctx;
    }

        
}