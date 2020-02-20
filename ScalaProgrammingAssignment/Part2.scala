object Part2{

  def compareTrees[T <: Ordered[T]](a: OTree[T], b: OTree[T]): Unit = {
    val x = a.compare(b)
    if (x < 0)
      println("Less")
    else if (x > 0)
      println("Greater")
    else
      println("Equal")
  }

  def test() {

    val tree1 = ONode(List(OLeaf(new OInt(6))))

    val tree2 = ONode(List(OLeaf(new OInt(3)),
      OLeaf(new OInt(4)),
      ONode(List(OLeaf(new OInt(5)))),
      ONode(List(OLeaf(new OInt(6)),
        OLeaf(new OInt(7))))))

    val treeTree1: OTree[OTree[OInt]] =
      ONode(List(OLeaf(OLeaf(new OInt(1)))))

    val treeTree2: OTree[OTree[OInt]] =
      ONode(List(OLeaf(OLeaf(new OInt(1))),
        OLeaf(ONode(List(OLeaf(new OInt(2)),
          OLeaf(new OInt(2)))))))


    print("tree1: ")
    println(tree1)
    print("tree2: ")
    println(tree2)
    print("treeTree1: ")
    println(treeTree1)
    print("treeTree2: ")
    println(treeTree2)
    print("Comparing tree1 and tree2: ")
    compareTrees(tree1, tree2)
    print("Comparing tree2 and tree2: ")
    compareTrees(tree2, tree2)
    print("Comparing tree2 and tree1: ")
    compareTrees(tree2, tree1)
    print("Comparing treeTree1 and treeTree2: ")
    compareTrees(treeTree1, treeTree2)
    print("Comparing treeTree2 and treeTree2: ")
    compareTrees(treeTree2, treeTree2)
    print("Comparing treeTree2 and treeTree1: ")
    compareTrees(treeTree2, treeTree1)


  }

  def main(args: Array[String]): Unit = {
    test()
  }
}

abstract class OTree[T <: Ordered[T]] extends Ordered[OTree[T]]

case class ONode[T <: Ordered[T]](v: List[OTree[T]]) extends OTree[T] {

  def NodeCompare(x:List[OTree[T]], y:List[OTree[T]]): Int = (x, y) match{
    case (List(), List()) => 0
    case (List(), _) => -1
    case (_, List()) => 1
    case (x::xs, y::ys) =>
      val ans = x.compare(y)
      if(ans == 0) NodeCompare(xs,ys)
      else ans
  }

  override def compare(that: OTree[T]): Int = that match {
    case ONode(ov) => NodeCompare(v, ov)
    case OLeaf(ov) => 1
  }
}

case class OLeaf[T <: Ordered[T]](v:T) extends OTree[T]{
  override def compare(that: OTree[T]): Int = that match {
    case ONode(ov) => -1
    case OLeaf(ov) => v.compare(ov)
  }
  override def toString: String = s"$v"
}


class OInt (n:Int) extends Ordered[OInt] {
  val data:Int = n
  override def compare(that: OInt): Int = this.data.compareTo(that.data)
  override def toString: String = s"$n"
}
