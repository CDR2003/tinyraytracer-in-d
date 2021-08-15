module gml.camera;

import gml.math;
import gml.viewport;

public class Camera
{
    public immutable Vector3 DEFAULT_ORIGIN = Vector3.zero;

    public immutable float DEFAULT_ASPECT_RATIO = 16f / 9f;

    public immutable float DEFAULT_SIZE = 2f;

    public immutable float DEFAULT_FOCAL_LENGTH = 1f;

    private Viewport _viewport;

    public this()
    {
        immutable auto width = DEFAULT_SIZE * DEFAULT_ASPECT_RATIO;
        _viewport = new Viewport(DEFAULT_ORIGIN, width, DEFAULT_SIZE, DEFAULT_FOCAL_LENGTH);
    }

    public Ray getRay(float u, float v) const
    {
        return _viewport.getRay(u, v);
    }
}