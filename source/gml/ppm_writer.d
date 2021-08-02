module gml.ppm_writer;

import std.stdio;
import gml.texture;

public class PpmWriter
{
    public this()
    {
    }

    public void save(const Texture texture, string filename) const
    {
        auto file = File(filename, "w");
        scope(exit) file.close();

        file.writeln("P3");
        file.writefln("%d %d", texture.width, texture.height);
        file.writeln("255");

        for (auto y = 0; y < texture.height; y++)
        {
            for (auto x = 0; x < texture.width; x++)
            {
                immutable auto color = texture[x, y];
                auto r = cast(int)(color.r * 255.999);
                auto g = cast(int)(color.g * 255.999);
                auto b = cast(int)(color.b * 255.999);
                file.writefln("%d %d %d", r, g, b);
            }
        }
    }
}