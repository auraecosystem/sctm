---
tittle: page
layout: site
features: 
author: kubu
---

<!-- Header -->
<div class="header">  
    <div class="logo">SCTM-for-Life</div>
    <div class="domain-select">
        Domain:
        <select>
            <option>Education</option>
        </select>
    </div>
    <div class="help">Help ?</div>
</div>

<!-- Panels Container -->
<div class="panels">
    <!-- Input Panel -->
    <div class="panel input-panel">
        <h2>Input Panel</h2>
        <textarea id="sctm-input" placeholder="Type SCTM symbols here..."></textarea>
    </div>

    <!-- Visualization Panel -->
    <div class="panel viz-panel">
        <h2>Visualization Panel</h2>
        <div id="knowledge-graph"></div>
        <div id="formula-plot"></div>
    </div>

    <!-- Execution / Output Console -->
    <div class="panel console-panel">
        <h2>Execution Console</h2>
        <pre id="execution-output">{}</pre>
    </div>
</div>

<!-- Scripts -->
<script src="https://d3js.org/d3.v7.min.js"></script>
<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>

<script>
// --- Helpers ---
// Fake parser: converts SCTM symbols into nodes and edges
function parseSCTM(input) {
    const nodes = [];
    const links = [];
    const formulas = [];

    const lines = input.split('\n').filter(l => l.trim() !== '');
    lines.forEach((line, i) => {
        const parts = line.split('->');
        if (parts.length === 2) {
            const source = parts[0].trim();
            const target = parts[1].trim();
            nodes.push({id: source});
            nodes.push({id: target});
            links.push({source, target});
            formulas.push({x: i+1, y: Math.floor(Math.random()*10)+1});
        } else {
            nodes.push({id: line.trim()});
            formulas.push({x: i+1, y: Math.floor(Math.random()*10)+1});
        }
    });

    return {nodes, links, formulas};
}

// --- D3 Knowledge Graph ---
function renderGraph(nodes, links) {
    d3.select("#knowledge-graph").selectAll("*").remove();

    const width = 400;
    const height = 200;

    const svg = d3.select("#knowledge-graph")
        .append("svg")
        .attr("width", width)
        .attr("height", height);

    const simulation = d3.forceSimulation(nodes)
        .force("link", d3.forceLink(links).id(d => d.id).distance(80))
        .force("charge", d3.forceManyBody().strength(-200))
        .force("center", d3.forceCenter(width/2, height/2));

    const link = svg.append("g")
        .attr("stroke", "#999")
        .selectAll("line")
        .data(links)
        .join("line")
        .attr("stroke-width", 2);

    const node = svg.append("g")
        .attr("stroke", "#fff")
        .attr("stroke-width", 1.5)
        .selectAll("circle")
        .data(nodes)
        .join("circle")
        .attr("r", 10)
        .attr("fill", "#3498db")
        .call(drag(simulation));

    const label = svg.append("g")
        .selectAll("text")
        .data(nodes)
        .join("text")
        .text(d => d.id)
        .attr("x", 12)
        .attr("y", 4)
        .style("font-size", "12px");

    simulation.on("tick", () => {
        link
            .attr("x1", d => d.source.x)
            .attr("y1", d => d.source.y)
            .attr("x2", d => d.target.x)
            .attr("y2", d => d.target.y);

        node
            .attr("cx", d => d.x)
            .attr("cy", d => d.y);

        label
            .attr("x", d => d.x)
            .attr("y", d => d.y);
    });

    function drag(sim) {
        function dragstarted(event, d) {
            if (!event.active) sim.alphaTarget(0.3).restart();
            d.fx = d.x;
            d.fy = d.y;
        }
        function dragged(event, d) {
            d.fx = event.x;
            d.fy = event.y;
        }
        function dragended(event, d) {
            if (!event.active) sim.alphaTarget(0);
            d.fx = null;
            d.fy = null;
        }
        return d3.drag()
            .on("start", dragstarted)
            .on("drag", dragged)
            .on("end", dragended);
    }
}

// --- Plotly Formula Plot ---
function renderPlot(formulas) {
    const trace = {
        x: formulas.map(f => f.x),
        y: formulas.map(f => f.y),
        type: 'scatter',
        mode: 'lines+markers',
        marker: {color: '#e74c3c'}
    };

    const layout = {
        margin: { t: 10, b: 30, l: 40, r: 10 },
        height: 200,
        xaxis: { title: "Step" },
        yaxis: { title: "Value" }
    };

    Plotly.newPlot('formula-plot', [trace], layout, {responsive: true});
}

// --- Live Update ---
const inputArea = document.getElementById("sctm-input");
inputArea.addEventListener("input", () => {
    const parsed = parseSCTM(inputArea.value);
    renderGraph(parsed.nodes, parsed.links);
    renderPlot(parsed.formulas);

    // Show console output
    document.getElementById("execution-output").textContent = JSON.stringify(parsed, null, 2);
});
</script>

<style>
/* --- Global Styles --- */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background: #f4f4f9;
    color: #333;
}

/* --- Header --- */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #2c3e50;
    color: #fff;
    padding: 10px 20px;
}

.header .logo {
    font-size: 1.5em;
    font-weight: bold;
}

.header .domain-select select {
    margin-left: 5px;
    padding: 2px 5px;
}

.header .help {
    cursor: pointer;
    font-weight: bold;
}

/* --- Panels Container --- */
.panels {
    display: flex;
    flex-wrap: wrap;
    padding: 20px;
    gap: 20px;
    justify-content: space-between;
}

/* --- Individual Panels --- */
.panel {
    background: #fff;
    border-radius: 8px;
    padding: 15px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    flex: 1 1 30%;
    min-width: 300px;
}

/* --- Specific Panels --- */
.input-panel textarea {
    width: 100%;
    height: 150px;
    resize: vertical;
    padding: 10px;
    font-family: monospace;
    font-size: 1em;
}

.viz-panel #knowledge-graph,
.viz-panel #formula-plot {
    width: 100%;
    height: 200px;
    margin-top: 10px;
    border: 1px solid #ccc;
}

.console-panel pre {
    background: #1e1e1e;
    color: #fff;
    padding: 10px;
    height: 150px;
    overflow-y: auto;
    border-radius: 5px;
    font-family: monospace;
}
</style>
