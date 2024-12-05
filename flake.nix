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
        };
    };
}
