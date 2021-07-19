package du.board.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import du.board.dao.BoardDAO;
import du.board.domain.BoardVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class BoardDAOImpl extends EgovAbstractMapper implements BoardDAO{

	@Override
	public List<BoardVO> selectBoardList(HashMap<String, Object> map) {
		
		return selectList("Board.selectBoardList", map);
	}

	@Override
	public int selectBoardListCnt(String title) {
		
		return selectOne("Board.selectBoardListCnt", title);
	}

	@Override
	public void insertBoard(BoardVO board) {
		insert("Board.insertBoard", board);
	}

}
