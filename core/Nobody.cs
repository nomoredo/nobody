namespace nobody.core
{
    /// <summary>
    /// Nobody is the master class to start all fluent functions
    /// </summary>
    public class Nobody : Anybody
    {
        public Nobody()
        {
                //register auto installers
                register_capabilities();
        }


        private void register_capabilities()
        {
            //register auto installers
            // var autoInstallers = AppDomain.CurrentDomain.GetAssemblies()
            //     .SelectMany(x => x.GetTypes())
            //     .Where(x => typeof(AnyPlugin).IsAssignableFrom(x) && !x.IsInterface && !x.IsAbstract)
            //     .Select(x => (AnyPlugin)Activator.CreateInstance(x)!);
            // foreach (var autoInstaller in autoInstallers)
            // {
            //     autoInstaller.register(this);
            // }
        }

        private void cleanup()
        {
            //register auto installers
            // var autoInstallers = AppDomain.CurrentDomain.GetAssemblies()
            //     .SelectMany(x => x.GetTypes())
            //     .Where(x => typeof(AnyPlugin).IsAssignableFrom(x) && !x.IsInterface && !x.IsAbstract)
            //     .Select(x => (AnyPlugin)Activator.CreateInstance(x)!);
            // foreach (var autoInstaller in autoInstallers)
            // {
            //     autoInstaller.cleanup(this);
            // }
        }


    }
}