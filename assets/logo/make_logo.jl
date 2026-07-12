# Generates assets/img/logo.svg.
#
# The mark is the EpiAware idea in one picture: several component distributions
# combining into a single joint distribution. The bold curve is not drawn by
# hand, it is the actual normalised mixture of the faint component densities
# below it, so the logo means what it says.
#
# Run from the repository root:
#     julia assets/logo/make_logo.jl

const W = 64.0          # viewBox width
const BASE = 52.0       # baseline y (SVG y grows downwards)
const X0 = 5.0          # first drawn x
const X1 = 59.0         # last drawn x
const NJ = 40           # samples for the joint curve
const NC = 22           # samples per component curve
const JOINT_H = 38.0    # height of the joint curve above the baseline
const COMP_H = 22.0     # height of the tallest component curve

gauss(x, mu, sig) = exp(-0.5 * ((x - mu) / sig)^2) / (sig * sqrt(2pi))

# Component distributions: (mean, sd, weight).
# Narrow, closely spaced components: each still reads as its own distribution,
# but they overlap enough that their sum is a single smooth curve rather than a
# lumpy ridge. The weights give the mixture its bell shape.
const COMPS = [
    (19.0, 6.6, 0.70),
    (25.5, 6.6, 1.05),
    (32.0, 6.6, 1.25),
    (38.5, 6.6, 1.05),
    (45.0, 6.6, 0.70)
]

mixture(x) = sum(w * gauss(x, mu, sig) for (mu, sig, w) in COMPS)

fmt(v) = string(round(v; digits = 1))

"Sample `f` across [a, b] and map density to SVG coordinates."
function points(f, scale, a, b, n)
    xs = range(a, b; length = n)
    [(x, BASE - scale * f(x)) for x in xs]
end

"Catmull-Rom through the samples, emitted as cubic Beziers for smooth curves."
function smooth_path(pts)
    io = IOBuffer()
    print(io, "M ", fmt(pts[1][1]), " ", fmt(pts[1][2]))
    n = length(pts)
    for i in 1:(n - 1)
        p0 = pts[max(i - 1, 1)]
        p1, p2 = pts[i], pts[i + 1]
        p3 = pts[min(i + 2, n)]
        c1 = (p1[1] + (p2[1] - p0[1]) / 6, p1[2] + (p2[2] - p0[2]) / 6)
        c2 = (p2[1] - (p3[1] - p1[1]) / 6, p2[2] - (p3[2] - p1[2]) / 6)
        print(io, " C ", fmt(c1[1]), " ", fmt(c1[2]), ", ",
            fmt(c2[1]), " ", fmt(c2[2]), ", ",
            fmt(p2[1]), " ", fmt(p2[2]))
    end
    String(take!(io))
end

# Scale each family so the tallest peak lands on its target height.
grid = range(X0, X1; length = 400)
joint_scale = JOINT_H / maximum(mixture, grid)
comp_peak = maximum(
    maximum(x -> w * gauss(x, mu, sig), grid) for (mu, sig, w) in COMPS
)
comp_scale = COMP_H / comp_peak

joint_d = smooth_path(points(mixture, joint_scale, X0, X1, NJ))

# Draw each component only across its own support, so the mark is not cluttered
# with long flat tails running along the baseline.
# Closed so each component can be filled as a soft density rather than stroked.
# Overlapping strokes crosshatch into a lattice; translucent fills do not.
function closed_path(f, scale, a, b, n)
    d = smooth_path(points(f, scale, a, b, n))
    string(d, " L ", fmt(b), " ", fmt(BASE), " L ", fmt(a), " ", fmt(BASE), " Z")
end

comp_ds = [
    closed_path(x -> w * gauss(x, mu, sig), comp_scale,
        max(X0, mu - 3.0sig), min(X1, mu + 3.0sig), NC)
    for (mu, sig, w) in COMPS
]

open(joinpath(@__DIR__, "..", "img", "logo.svg"), "w") do io
    println(io, """
    <svg width="64" height="64" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="EpiAware">
      <title>EpiAware</title>
      <desc>Several component distributions combining into one joint distribution.</desc>
      <defs>
        <linearGradient id="joint" x1="0" y1="52" x2="0" y2="10" gradientUnits="userSpaceOnUse">
          <stop offset="0" stop-color="#14708E"/>
          <stop offset="1" stop-color="#2CA6A4"/>
        </linearGradient>
      </defs>
      <path d="M4 52 H60" stroke="#9DB4C0" stroke-width="1.4" stroke-linecap="round" opacity="0.4"/>
      <g fill="#2CA6A4" fill-opacity="0.10" stroke="none">""")
    for d in comp_ds
        println(io, """    <path d="$d"/>""")
    end
    println(io, """  </g>
      <g fill="none" stroke="#14708E" stroke-width="0.9" stroke-opacity="0.5" stroke-linejoin="round" stroke-linecap="round">""")
    for d in comp_ds
        println(io, """    <path d="$d"/>""")
    end
    println(io, """  </g>
      <path d="$joint_d" fill="none" stroke="url(#joint)" stroke-width="4.2" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>""")
end

println("wrote assets/img/logo.svg")
