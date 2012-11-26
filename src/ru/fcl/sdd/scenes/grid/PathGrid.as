/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:44
 */
package ru.fcl.sdd.scenes.grid
{
import as3isolib.display.scene.IsoGrid;
import as3isolib.display.scene.IsoScene;

import ru.fcl.sdd.IsoConfig;

public class PathGrid extends IsoScene
{
    private var grid:IsoGrid;

    [PostConstruct]
    public function init():void
    {
        grid = new IsoGrid();
        grid.cellSize = IsoConfig.CELL_SIZE;
        grid.setGridSize(13,21);

        this.addChild(grid);
    }
}
}
