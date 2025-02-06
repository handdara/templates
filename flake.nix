{
    description = "personal use nix templates for handdara";
    outputs = {self}: {
        templates = {
            tex = {
                path = ./tex;
                description = "simple flake template for writing latex";
            };
            R = {
                path = ./r;
                description = "simple flake template for R";
            };
            zig = {
                path = ./zig;
                description = "simple flake template for zig";
            };
            python = {
                path = ./python;
                description = "simple flake template for python";
            };
            runapp = {
                path = ./runapp;
                description = "Simple app runner for testing stuff pre-installation";
            };
        };
    };
}
