

const { core } = Deno;
const { ops } = core;

function argsToMessage(...args) {
  return args.map((arg) => JSON.stringify(arg)).join(" ");
}

const console = {
  log: (...args) => {
    core.print(`[out]: ${argsToMessage(...args)}\n`, false);
  },
  error: (...args) => {
    core.print(`[err]: ${argsToMessage(...args)}\n`, true);
  },
};

const nobody = {
  readFile: (path) => {
    return ops.op_read_file(path);
  },
  writeFile: (path, contents) => {
    return ops.op_write_file(path, contents);
  },
  removeFile: (path) => {
    return ops.op_remove_file(path);
  },
  fetch: async (url) => {
    return ops.op_fetch(url);
  },
  print: (message) => {
    core.print(message);
  },
  exit: (code) => {
    core.exit(code);
  },
  wait: (milliseconds) => {
    return new Promise((resolve) => {
      setTimeout(resolve, milliseconds);
    });
  },
};

function setTimeout(callback, delay) {
  ops.op_set_timeout(delay).then(callback);
}

