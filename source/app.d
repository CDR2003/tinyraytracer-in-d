import std.stdio;
import std.algorithm;
import std.conv;
import gml.vector;

void render()
{
	immutable int width = 1024;
	immutable int height = 768;
	auto framebuffer = new Vector3[width * height];

	for (int y = 0; y < height; y++)
	{
		for (int x = 0; x < width; x++)
		{
			auto index = y * width + x;
			framebuffer[index] = Vector3(y / float(height), x / float(width), 0);
		}
	}

	auto file = File("../out.ppm", "wb");
	scope(exit) file.close();

	file.write("P6\n" ~ to!string(width) ~ " " ~ to!string(height) ~ "\n255\n");
	for (int i = 0; i < width * height; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			immutable float component = max(0f, min(1f, framebuffer[i][j]));
			immutable char ch = to!char(255 * component);
			file.write(ch);
		}
	}
}

void main()
{
	render();
}