pyramid = function(){
   
   var width = 800,
       height = 600
       margin = {top:0, bottom:0, left:0, right:0}
       xScale = d3.scale.linear();
       yScale = d3.scale.linear();
       ;
       
   function chart(selection){
      selection.each({
         function(d, i){
            var g = d3.select(this);
            
            var xMax = d3.max(d, function(d1){return d1.count});
            var yMax = 10;
            
            xScale.domain([-xMax, xMax]);
            yScale.domain([0,yMax]);
            
            var h = 100/yMax + "%";
            
            var bars = g.selectAll("rect.bars").data(d);
            
            bars.enter().append("rect")
               .attr("class", function(d){return ["bars",d.gender].join(" ");})
               .attr("x", xScale(0))
               .attr("y", function(d){return yScale(d.ageGroup);})
               .attr("height", h)
               .attr("width", function(d){return xScale(d.count);})
         }
      })
   }
   
   function rescale(){
      var w = width - (margin.left + margin.right);
      var h = height - (margin.top + margin.bottom);
      
      xScale.range([margin.left, w]);
      yScale.range([h, margin.bottom]);
      return chart;
   }
   
   chart.draw = function(){
      rescale();
      //
   }
   
   chart.margin = function(_){
      if (!arguments.length){
         return margin;
      }
      margin = _;
      return chart;
   }
   
   chart.width = function(_){
      if (!arguments.length){
         return width;
      }
      width = _;
      return chart;
   }
   
   chart.height = function(_){
      if (!arguments.length){
         return height;
      }
      height = _;
      return chart;
   }

   return chart
}