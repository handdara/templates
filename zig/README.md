# handdara zig template

need to change the name of the binary in:
-   `flake.nix` under `pname` in the output derivation
-   `build.zig` in the `exe` definition

also a good idea to change the package name in `build.zig.zon`.

## usage

see the `justfile` for usage commands.

> [!NOTE]
> the `build.zig.zon` is more here for lsp/debugging purposes. if deleted it'll be generated when
> running the `preBuild` hook

## debugging with lldb

not sure why but `(lldb) b main` only works on the `zig-out` binary built in the dev shell, and not
on the `result` binary built in the nix derivation. I guess I'll just figure it out another time. But
for now, to debug:

1.  drop into dev shell `just dev`
2.  build `zig build`
3.  start up debugger `lldb zig-out/bin/z.out -- ARGS GO HERE`
