module gml.texture;

import std.algorithm;
import gml.math;
import gml.ppm_writer;

public class Texture
{
    private int _width;

    private int _height;

    private Color[] _pixels;

    public this(int width, int height)
    {
        _width = width;
        _height = height;
        _pixels = new Color[width * height];
    }

    public int width() pure const nothrow
    {
        return _width;
    }

    public int height() pure const nothrow
    {
        return _height;
    }

    public Color opIndex(int x, int y) pure const
    {
        return _pixels[y * width + x];
    }

    public void opIndexAssign(Color color, int x, int y)
    {
        _pixels[y * width + x] = color;
    }

    public void saveToPpm(string filename) const
    {
        auto writer = new PpmWriter();
        writer.save(this, filename);
    }
}