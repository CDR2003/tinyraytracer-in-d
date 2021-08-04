import std.stdio;
import std.algorithm;
import std.conv;
import std.process;

import gml;

Color getBackgroundColor(const Ray ray)
{
	immutable auto direction = ray.direction.normalized;
	immutable auto t = 0.5f * (direction.y + 1.0f);
	return lerp(Color(1.0f, 1.0f, 1.0f), Color(0.5f, 0.7f, 1.0f), t);
}

void main()
{
	immutable float aspectRatio = 16f / 9f;
	immutable int width = 400;
	immutable int height = cast(int)(width / aspectRatio);

	auto viewport = new Viewport(2f * aspectRatio, 2f, 1f);

	auto texture = new Texture(width, height);
	for (int y = 0; y < texture.height; y++)
	{
		for (int x = 0; x < texture.width; x++)
		{
			immutable auto u = cast(float)x / texture.width;
			immutable auto v = cast(float)y / texture.height;
			immutable auto ray = viewport.getRay(u, v);
			immutable auto color = getBackgroundColor(ray);
			texture[x, y] = color;
		}
	}
	texture.saveToPpm("../out.ppm");

	spawnShell("start ../out.ppm");
}