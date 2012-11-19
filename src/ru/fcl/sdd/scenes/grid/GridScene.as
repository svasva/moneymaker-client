/**
 * User: Jessie
 * Date: 14.11.12
 * Time: 13:44
 */
package ru.fcl.sdd.scenes.grid
{
import as3isolib.display.scene.IsoGrid;
import as3isolib.display.scene.IsoScene;

public class GridScene extends IsoScene
{
    private var grid:IsoGrid;

    [PostConstruct]
    public function init():void
    {
        grid = new IsoGrid();
        grid.cellSize = 10;
        grid.setGridSize(1000,1000);

        this.addChild(grid);
    }
}
}
