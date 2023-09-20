
namespace working
{
    public static class ExTime
    {
        private static double ToDouble<T>(this T value) where T : struct, IConvertible
        {
            return Convert.ToDouble(value);
        }

        public static TimeSpan seconds<T>(this T value) where T : struct, IConvertible
        {
            return TimeSpan.FromSeconds(value.ToDouble());
        }

        public static TimeSpan minutes<T>(this T value) where T : struct, IConvertible
        {
            return TimeSpan.FromMinutes(value.ToDouble());
        }

        public static TimeSpan hours<T>(this T value) where T : struct, IConvertible
        {
            return TimeSpan.FromHours(value.ToDouble());
        }

        public static TimeSpan days<T>(this T value) where T : struct, IConvertible
        {
            return TimeSpan.FromDays(value.ToDouble());
        }

        public static TimeSpan weeks<T>(this T value) where T : struct, IConvertible
        {
            return TimeSpan.FromDays(7 * value.ToDouble());
        }

        // Note: This assumes each month has 30 days. 
        public static TimeSpan months<T>(this T value) where T : struct, IConvertible
        {
            return TimeSpan.FromDays(30 * value.ToDouble());
        }

        // Note: This assumes each year has 365 days.
        public static TimeSpan years<T>(this T value) where T : struct, IConvertible
        {
            return TimeSpan.FromDays(365 * value.ToDouble());
        }
    }
}
