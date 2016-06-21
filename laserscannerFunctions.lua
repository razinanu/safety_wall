function drawRect(width, height,height_down)
    m1=simGetObjectMatrix(sensorRefHandle,-1)

    p0 = {0,-height,0}
    p1 = {width,-height,0}
    p2 = {width,height,0}
    p3 = {0,height,0}

    p0 = simMultiplyVector(m1,p0)
    p1 = simMultiplyVector(m1,p1)
    p2 = simMultiplyVector(m1,p2)
    p3 = simMultiplyVector(m1,p3)

    t0= {p0[1],p0[2],p0[3],p1[1],p1[2],p1[3]}
    t1= {p1[1],p1[2],p1[3],p2[1],p2[2],p2[3]}
    t2= {p2[1],p2[2],p2[3],p3[1],p3[2],p3[3]}
    t3= {p3[1],p3[2],p3[3],p0[1],p0[2],p0[3]}

    simAddDrawingObjectItem(walls,t0)
    simAddDrawingObjectItem(walls,t1)
    simAddDrawingObjectItem(walls,t2)
    simAddDrawingObjectItem(walls,t3)
end

-- tests if any point in measuredData is inside a hardcoded rectangle
-- <----- RECT_WIDTH --->
--  _____________________
-- |                     |
-- |                     |
-- |                     |  RECT_HEIGTH
-- |                     |
-- |__________O__________|
--       Laserscanner
function processPoints(measuredData)

    obstacle = false
    pointCount = table.getn(measuredData)
    for i=1,pointCount-3, 3 do
	point = {}
	point[1] = measuredData[i]
	point[2] = measuredData[i+1]
	point[3] = measuredData[i+2]
      --  if(measuredData[i] == NIL or measuredData[i+1] == NIL)then
	  -- print("pointX: " .. measuredData[i])
	 --  print("pointY: " .. measuredData[i])
       -- end
	if(isPointInRect(point)) then
	    --print("bad 1")
	    obstacle = true


	--else print("good 1")
	    end
    print(obstacle)
    end

end

function isPointInRect(point)
    drawRect(RECT_WIDTH,RECT_HEIGHT,RECT_HEIGHT_DOWN)
      --- X point[1] is height, Y point[2] is width
     --print("pointX0: " .. point[1])
    -- print("pointY0: " .. point[2])
    inXRange = (point[1] > -RECT_HEIGHT_DOWN   and point[1] <  RECT_HEIGHT)
    inYRange = (point[2] > -RECT_WIDTH and point[2] < RECT_WIDTH)

    if(inXRange and inYRange) then
	return true
    else
	return false
    end
end
