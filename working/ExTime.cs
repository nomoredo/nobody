namespace working;

public static class ExTime {
    public static TimeSpan seconds<T>(this T value) where T : struct, IConvertible
    {
        return TimeSpan.FromSeconds(Convert.ToDouble(value));
    }

    public static TimeSpan minutes<T>(this T value) where T : struct, IConvertible
    {
        return TimeSpan.FromMinutes(Convert.ToDouble(value));
    }

    public static TimeSpan hours<T>(this T value) where T : struct, IConvertible
    {
        return TimeSpan.FromHours(Convert.ToDouble(value));
    }

    public static TimeSpan days<T>(this T value) where T : struct, IConvertible
    {
        return TimeSpan.FromDays(Convert.ToDouble(value));
    }

    public static TimeSpan weeks<T>(this T value) where T : struct, IConvertible
    {
        return TimeSpan.FromDays(7 * Convert.ToDouble(value));
    }

    public static TimeSpan months<T>(this T value) where T : struct, IConvertible
    {
        return TimeSpan.FromDays(30 * Convert.ToDouble(value));
    }

    public static TimeSpan years<T>(this T value) where T : struct, IConvertible
    {
        return TimeSpan.FromDays(365 * Convert.ToDouble(value));
    }


}
